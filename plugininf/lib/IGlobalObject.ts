import ILocalDB from "./db/local/ILocalDB";
import { IMask } from "./IMask";
import { IPropertyGlobal } from "./IPropertyGlobal";

export default interface IGlobalObject {
    homedir: string;
    maskgate: IMask;
    property: IPropertyGlobal;
    /**
     * Создание или загрузка ранее созданой темповой таблицы
     * @param name наименование
     */
    createTempTable<T>(name: string): Promise<ILocalDB<T>>;
}
declare global {
    var homedir: string;
    var maskgate: IMask;
    var property: IPropertyGlobal;
    /**
     * Создание или загрузка ранее созданой темповой таблицы
     * @param name наименование
     */
    function createTempTable<T>(name: string): Promise<ILocalDB<T>>;
}
