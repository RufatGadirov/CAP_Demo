const cds = require('@sap/cds');
const cdse = require('cdse');
module.exports = cds.service.impl(async function () {
    const { A_BusinessPartnerAddress: Addresses } = this.entities(
        'API_BUSINESS_PARTNER'
    )

    /*  const { Products: ProductTab } = this.entities(
          'NorthWind'
      )*/

    const { Products, LocalProducts } = this.entities;

    let service = await cds.connect.to('NorthWind');
    //this.on('READ', Products, request => {  //-->other alternative!
    // const tx = extSrv.transaction(request)
    // this.on('READ', Products, async () => {
    // const result = service.tx(request).run(request.query);
    //return service.tx(request).run(request.query); -->other alternative!
    //const result = await service.run({ url: 'Products' });
    // return result.value;
    //});

    this.on('READ', 'Products', request => {
        const tx = service.transaction(request)
        //const response = await tx.get('/Products')
        const response = tx.read(Products)
        const cqn = SELECT.from(Products)
        const requestData = request.data;
        console.log(requestData);
       /* return cds.run([
            INSERT.into(LocalProducts).as(cqn.SELECT(request.data))
        ])*/
        return tx.run(cqn)
    })

    /* this.after('READ', 'Products', xs => {
         //const result =  cds.run({ url: 'Products' });
         //return result.value;
         xs.forEach(x => {
             // console.log(SELECT.from(ProductTab));
             return cds.run(
                 INSERT.into(LocalProducts).columns(
                     'ID',
                     'Name'
                 ).rows(
                     [x.ID, x.Name],
                 )
             )
         })
     });*/
    //console.log(SELECT.from(ProductTab));
    return cds.run([
        INSERT.into(Addresses).columns(
            'BusinessPartner',
            'AddressID',
            'CityName',
            'StreetName'
        ).rows(
            ['1003764', '28238', 'Walldorf', 'Dietmar-Hopp-Allee'],
            ['1003765', '28241', 'Palo Alto', 'Hillview Avenue'],
            ['1003766', '28244', 'Hallbergmoos', 'Zeppelinstraße'],
            ['1003767', '28247', 'Potsdam', 'Konrad-Zuse-Ring']
        )
        // add more INSERTs here, as appropriate
        /*INSERT.into(Products).columns(
            'ID',
            'Name',
            'Description',
        ).rows(
            ['1003764', 'TestProd', 'Desc'],
        )*/
    ]
    )
})


/*[
            INSERT.into(Products).as(SELECT.from(service.entities.Products))
        ]*/