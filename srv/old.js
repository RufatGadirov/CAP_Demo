//const cds = require('@sap/cds');
//const cdse = require('cdse');

//module.exports = cds.service.impl(async function () {
/*
    let { Products, LocalProducts } = this.entities;
    const service = await cdse.connect.to('NorthWind');

    this.on('READ', Products, async () => {
        const result = await service.run({ url: 'Products' });
        return result.value;
    });

    this.after('READ', 'Products', xs => {
        const newBooks = []
        xs.forEach(x => {
            console.log(SELECT.from(LocalProducts));
            return cds.run(
                INSERT.into(LocalProducts).columns(
                    'ID',
                    'Name'
                ).rows(
                    [x.ID, x.Name],
                )
            )
        })
    })*/
//})