import { isTrue, questionReadline } from "../util";
import * as fs from "fs";
import * as path from "path";
import { isEmpty } from "../util";
import * as YAML from "js-yaml";
import * as TOML from "@iarna/toml";

export async function changeTomlToYaml() {
    const dir = await questionReadline("Directory config:");
    const isDelete = isTrue(await questionReadline("Delete old property(no):",'no'));
    if (isEmpty(dir)) {
        process.exit(1);
    }
    fs.readdirSync(dir).forEach((key) => {
        if (key.endsWith("toml")) {
            console.log(`File ${key} to ${key.replace(".toml",".yaml")}`)
            const temp = TOML.parse(fs.readFileSync(path.join(dir, key)).toString());
            fs.writeFileSync(path.join(dir, key.replace(".toml",".yaml")), YAML.dump(temp.data));
            if (isDelete) {
                fs.unlinkSync(path.join(dir, key));
            }
        }
    })

}