/* eslint-disable max-statements */
/* eslint-disable max-lines-per-function */
/* eslint-disable max-len */
import * as fs from "fs";
import * as path from "path";
import {questionReadline, getDir, isEmpty, isTrue} from "../util";

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
        json: "",
        modify: "",
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
--changeset ${user}:pkg_json_${pSuffix} dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_json_${pSuffix} cascade;
    
CREATE SCHEMA pkg_json_${pSuffix}
    AUTHORIZATION \${user.update};
    
ALTER SCHEMA pkg_json_${pSuffix} OWNER TO \${user.update};
${template.json}
    `,
    );

    fs.writeFileSync(
        path.join(dir, `pkg_${pSuffix}.sql`),
        `--liquibase formatted sql
--changeset template:pkg_${pSuffix} dbms:postgresql runOnChange:true splitStatements:false stripComments:false
DROP SCHEMA IF EXISTS pkg_${pSuffix} cascade;
    
CREATE SCHEMA pkg_${pSuffix}
    AUTHORIZATION \${user.update};
    
ALTER SCHEMA pkg_${pSuffix} OWNER TO \${user.update};
${template.modify}
    `,
    );
}

async function CreateTemplateFn(dir: string, packageSuffix?: string) {
    let pSuffix = packageSuffix;
    const res = {
        json: "",
        modify: "",
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
        throw new Error(`Not fount ${jsonFile} or ${modifyFile}`);
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
    res.json = `
CREATE FUNCTION pkg_json_${pSuffix}.f_modify_${fSuffix}(pv_user varchar, pk_session varchar, pc_json jsonb) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '\${user.table}', 'pkg_json_${pSuffix}', 'pkg_${pSuffix}', 'public'
    AS $$
declare
  -- var package
  gv_error sessvarstr;
  u sessvarstr;

  -- var fn
  po${nameTable}  \${user.table}.${nameTable};
  vv_action varchar(1);
begin
  -- Init
  gv_error = sessvarstr_declare('pkg', 'gv_error', '');
  u = sessvarstr_declare('pkg', 'u', 'U');

  -- Reset global
  perform pkg.p_reset_response();


  --JSON -> rowtype Example
  --po${nameTable}.ck_id = (nullif(trim(pc_json#>>'{data,ck_id}'), ''))::uuid;
  --po${nameTable}.cv_data = nullif(trim(pc_json#>>'{data,cv_data}'), '');
  --po${nameTable}.cn_num = (nullif(trim(pc_json#>>'{data,cn_num}'), ''))::bigint;
  po${nameTable}.ck_user = pv_user;
  po${nameTable}.ct_change = CURRENT_TIMESTAMP;
  vv_action = (pc_json#>>'{service,cv_action}');

  --check access
  perform pkg_access.p_check_access(pv_user);
  if nullif(gv_error::varchar, '') is not null then
    return '{"ck_id":"","cv_error":' || pkg.p_form_response() || '}';
  end if;
  --lock row
  if vv_action = u::varchar then
    perform pkg_${pSuffix}.p_lock_${fSuffix}(po${nameTable}.ck_id::varchar);
  end if;
  --modify
  po${nameTable} := pkg_${pSuffix}.p_modify_${fSuffix}(vv_action, po${nameTable});
  --log
  perform pkg_log.p_save(pv_user, pk_session, pc_json, 'pkg_json_${pSuffix}.f_modify_${fSuffix}', po${nameTable}.ck_id::varchar, vv_action);
  return '{"ck_id":"' || coalesce(po${nameTable}.ck_id::varchar, '') || '","cv_error":' || pkg.p_form_response() || '}';
end;
$$;

ALTER FUNCTION pkg_json_${pSuffix}.f_modify_${fSuffix}(varchar, varchar, jsonb) OWNER TO \${user.update};

    `;

    res.modify = `
CREATE FUNCTION pkg_${pSuffix}.p_modify_${fSuffix}(pv_action varchar, INOUT po${nameTable} \${user.table}.${nameTable}) RETURNS \${user.table}.${nameTable}
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pkg_${pSuffix}', '\${user.table}', 'public'
    AS $$
declare
  -- var package
  i sessvarstr;
  u sessvarstr;
  d sessvarstr;

  gv_error sessvarstr;

begin
    -- init
    i = sessvarstr_declare('pkg', 'i', 'I');
    u = sessvarstr_declare('pkg', 'u', 'U');
    d = sessvarstr_declare('pkg', 'd', 'D');
    gv_error = sessvarstr_declare('pkg', 'gv_error', '');

    if pv_action = d::varchar then
        delete from \${user.table}.${nameTable} where ck_id = po${nameTable}.ck_id;
        return;
    end if;
    if nullif(gv_error::varchar, '') is not null then
   	    return;
    end if;
    if pv_action = i::varchar then
      insert into \${user.table}.${nameTable} values (po${nameTable}.*);
    elsif pv_action = u::varchar then
      update \${user.table}.${nameTable} set
        (ck_user, ct_change) = (po${nameTable}.ck_user, po${nameTable}.ct_change)
      where ck_id = po${nameTable}.ck_id;
      if not found then
        perform pkg.p_set_error(504);
      end if;
    end if;
end;
$$;

ALTER FUNCTION pkg_${pSuffix}.p_modify_${fSuffix}(pv_action character varying, INOUT po${nameTable} \${user.table}.${nameTable}) OWNER TO \${user.update};

CREATE FUNCTION pkg_${pSuffix}.p_lock_${fSuffix}(pk_id varchar) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO '\${user.table}', 'pkg_${pSuffix}', 'public'
    AS $$
declare
  vn_lock bigint;
begin
  if pk_id is not null then
    select 1 into vn_lock from \${user.table}.${nameTable} where ck_id::varchar = pk_id for update nowait;
  end if;
end;
$$;


ALTER FUNCTION pkg_${pSuffix}.p_lock_${fSuffix}(pk_id varchar) OWNER TO \${user.update};
`;

    if (isEmpty(packageSuffix)) {
        const json = fs.readFileSync(jsonFile).toString();
        const modify = fs.readFileSync(modifyFile).toString();

        fs.writeFileSync(
            jsonFile,
            `${json}
            ${res.json}
            `,
        );

        fs.writeFileSync(
            modifyFile,
            `${modify}
            ${res.modify}
            `,
        );
    }

    return res;
}

export const cliPostgreSql = async () => {
    const dir = getDir(
        await questionReadline(
            "Choice directory (./dbms/package):",
            "./dbms/package",
        ),
    );

    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, {recursive: true});
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
            return CreateTemplateFn(dir);
    }
};
