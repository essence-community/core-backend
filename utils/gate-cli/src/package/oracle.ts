/* eslint-disable max-statements */
/* eslint-disable max-lines-per-function */
/* eslint-disable max-len */
import * as fs from "fs";
import * as path from "path";
import { questionReadline, getDir, isEmpty, isTrue } from "../util";
import { UtilError } from "../UtilError";

async function CreatePackage(dir: string) {
    let pSuffix = null;

    while (isEmpty(pSuffix)) {
        pSuffix = await questionReadline("Package suffix:");
    }

    let user = null;

    while (isEmpty(user)) {
        user = await questionReadline("Author:");
    }
    let template = {
        json: {
            body: "",
            header: "",
        },
        modify: {
            body: "",
            header: "",
        },
    };

    if (
        isTrue(await questionReadline("Create template function(yes):", "yes"))
    ) {
        // eslint-disable-next-line no-use-before-define,@typescript-eslint/no-use-before-define
        template = await CreateTemplateFn(dir, pSuffix);
    }
    fs.writeFileSync(
        path.join(dir, `pkg_json_${pSuffix}.sql`),
        `--liquibase formatted sql
--changeset ${user}:pkg_json_${pSuffix} dbms:oracle runOnChange:true endDelimiter:/ splitStatements:true stripComments:false

create or replace package \${user.update}.pkg_json_${pSuffix} is
${template.json.header}
end pkg_json_${pSuffix};
/
create or replace package body \${user.update}.pkg_json_${pSuffix} is
${template.json.body}
end pkg_json_${pSuffix};
/
`,
    );

    fs.writeFileSync(
        path.join(dir, `pkg_${pSuffix}.sql`),
        `--liquibase formatted sql
--changeset ${user}:pkg_${pSuffix} dbms:oracle runOnChange:true endDelimiter:/ splitStatements:true stripComments:false

create or replace package \${user.update}.pkg_${pSuffix} is
${template.modify.header}
end pkg_${pSuffix};
/
create or replace package body \${user.update}.pkg_${pSuffix} is
${template.modify.body}
end pkg_${pSuffix};
/
    `,
    );
}

async function CreateTemplateFn(dir: string, packageSuffix?: string) {
    let pSuffix = packageSuffix;
    const res = {
        json: {
            body: "",
            header: "",
        },
        modify: {
            body: "",
            header: "",
        },
    };

    while (isEmpty(pSuffix)) {
        pSuffix = await questionReadline("Package suffix:");
    }

    const jsonFile = path.join(dir, `pkg_json_${pSuffix}.sql`);
    const modifyFile = path.join(dir, `pkg_${pSuffix}.sql`);

    if (
        isEmpty(packageSuffix) &&
        (!fs.existsSync(jsonFile) || !fs.existsSync(modifyFile))
    ) {
        throw new Error(`Not found ${jsonFile} or ${modifyFile}`);
    }

    let fSuffix = null;

    while (isEmpty(fSuffix)) {
        fSuffix = await questionReadline("Function suffix:");
    }

    let nameTable = null;

    while (isEmpty(nameTable)) {
        nameTable = await questionReadline("Name table:");
    }

    // eslint-disable-next-line max-len
    res.json.header = `
  function f_modify_${fSuffix}(pv_user in varchar2, pk_session in varchar2, pc_json in clob) return varchar2;
`;

    res.json.body = `
  function f_modify_${fSuffix}(pv_user in varchar2, pk_session in varchar2, pc_json in clob) return varchar2 is
    vo${nameTable} ${nameTable}%rowtype;
    vv_action  varchar2(1);
  begin
    --reset global
    pkg.p_reset_response;
    --JSON -> rowtype example
    select trim(ck_id),
           pv_user,
           systimestamp,
           jt.cv_action
      into vo${nameTable}.ck_id,
           vo${nameTable}.ck_user,
           vo${nameTable}.ct_change,
           vv_action
      from json_table(pc_json,
                      '$' columns ck_id varchar2(4000 char) path '$.data.ck_id',
                      cv_action varchar2(4000 char) path '$.service.cv_action') jt;
    --check access
    pkg_access.p_check_access(pv_user, vo${nameTable}.ck_id);
    if pkg.gv_error is not null then
      return '{"ck_id":"","cv_error":' || pkg.p_form_response || '}';
    end if;
    --lock
    pkg_${pSuffix}.p_lock_${fSuffix}(vo${nameTable}.ck_id);
    --check and save
    pkg_${pSuffix}.p_modify_${fSuffix}(vv_action, vo${nameTable});
    --Log
    pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_${pSuffix}.f_modify_${fSuffix}', vo${nameTable}.ck_id, vv_action);
    return '{"ck_id":"' || vo${nameTable}.ck_id || '","cv_error":' || pkg.p_form_response || '}';
  end f_modify_${fSuffix};
`;

    res.modify.header = `
  procedure p_lock_${fSuffix}(pk_id in ${nameTable}.ck_id%type);

  procedure p_modify_${fSuffix}(pv_action in varchar2, po${nameTable} in out ${nameTable}%rowtype);
`;

    res.modify.body = `
  procedure p_lock_${fSuffix}(pk_id in ${nameTable}.ck_id%type) is
    vn_lock number;
  begin
    if pk_id is not null then
      select 1 into vn_lock from ${nameTable} where ck_id = pk_id for update nowait;
    end if;
  end;
  
  procedure p_modify_${fSuffix}(pv_action in varchar2, po${nameTable} in out ${nameTable}%rowtype) is
  begin
    if pv_action = pkg.d then
      delete ${nameTable} where ck_id = po${nameTable}.ck_id;
    else
      /**/
      if pv_action = pkg.i and pkg.gv_error is null then
        insert into ${nameTable} values po${nameTable};
      elsif pv_action = pkg.u and pkg.gv_error is null then
        update ${nameTable} set row = po${nameTable} where ck_id = po${nameTable}.ck_id;
        if sql%notfound then
          pkg.p_set_error(504);
        end if;
      end if;
    end if;
  end p_modify_${fSuffix};
`;

    if (isEmpty(packageSuffix)) {
        throw new UtilError(
            "Not implemented. Ask to core team to add this feature",
        );
    }

    return res;
}

export const cliOracle = async () => {
    const dir = getDir(
        await questionReadline(
            "Choice directory (./dbms/package):",
            "./dbms/package",
        ),
    );

    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }

    switch (
        await questionReadline(
            "1 - Create package\n2 - Create template function\n(1):",
            "1",
        )
    ) {
        case "1":
            return CreatePackage(dir);
        case "2":
            throw new UtilError(
                "Not implemented. Ask to core team to add this feature",
            );
    }
};
