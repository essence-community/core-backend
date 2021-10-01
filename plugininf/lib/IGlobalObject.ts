import ILocalDB from "./db/local/ILocalDB";
export default interface IGlobalObject extends NodeJS.Global {
    homedir: string;
    maskgate: any;
    property: any;
    /**
     * Создание или загрузка ранее созданой темповой таблицы
     * @param name наименование
     */
    createTempTable<T>(name: string): Promise<ILocalDB<T>>;
}
