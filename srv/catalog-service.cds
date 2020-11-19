using {NorthWind as external} from './external/NorthWind.csn';
using {API_BUSINESS_PARTNER} from './external/API_BUSINESS_PARTNER';
using {my.app as app} from '../db/data-model';

service CatalogService {

    @readonly
    entity BusinessPartnerAddress as projection on API_BUSINESS_PARTNER.A_BusinessPartnerAddress {
        BusinessPartner, AddressID, CityName, StreetName

    //LastName, FirstName, BusinessPartnerCategory

    } actions {
        // bound actions/functions
        action addRating(ID : Integer);
    }


    // @cds.persistence.skip
    entity Products               as projection on external.Products {
        key ID, Name, Description, ReleaseDate, DiscontinuedDate, Rating, Price

    }

    entity LocalProducts          as
        select from app.LocalProducts {
            *,

        };

}

annotate CatalogService.BusinessPartnerAddress with @UI : {
    LineItem         : [
    {
        $Type : 'UI.DataField',
        Value : BusinessPartner,
        Label : 'Business Partner ID'
    },
    {
        $Type : 'UI.DataField',
        Value : AddressID,
        Label : 'Address ID'
    },
    {
        $Type : 'UI.DataField',
        Value : CityName,
        Label : 'City'
    }
    ],
    SelectionFields  : [
    BusinessPartner,
    AddressID,
    CityName
    ],
    Facets           : [{
        $Type  : 'UI.CollectionFacet',
        Label  : 'Product Details',
        Facets : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Main',
            Label  : 'Main Facet'
        }]
    }],
    FieldGroup #Main : {Data : [
    {
        Value : BusinessPartner,
        Label : 'ID'
    },
    {Value : AddressID},
    {Value : CityName}
    //{Value : price},
    // {Value : currency_code}
    ]}
};


annotate CatalogService.Products with @UI : {
    LineItem         : [
    {
        $Type : 'UI.DataField',
        Value : ID,
        Label : 'ID'
    },
    {
        $Type : 'UI.DataField',
        Value : Name,
        Label : 'Name'
    },
    {
        $Type : 'UI.DataField',
        Value : Description,
        Label : 'Description'
    }
    ],
    SelectionFields  : [
    ID,
    Name,
    Description
    ],
    Facets           : [{
        $Type  : 'UI.CollectionFacet',
        Label  : 'Product Details',
        Facets : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Main',
            Label  : 'Main Facet'
        }]
    }],
    FieldGroup #Main : {Data : [
    {
        Value : ID,
        Label : 'ID'
    },
    {Value : Name},
    {Value : Description}
    //{Value : price},
    // {Value : currency_code}
    ]}
};

annotate CatalogService.LocalProducts with @UI : {
    LineItem         : [
    {
        $Type : 'UI.DataField',
        Value : ID,
        Label : 'ID'
    },
    {
        $Type : 'UI.DataField',
        Value : Name,
        Label : 'Name'
    }
    ],
    SelectionFields  : [
    ID,
    Name,
    ],
    Facets           : [{
        $Type  : 'UI.CollectionFacet',
        Label  : 'Product Details',
        Facets : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Main',
            Label  : 'Main Facet'
        }]
    }],
    FieldGroup #Main : {Data : [
    {
        Value : ID,
        Label : 'ID'
    },
    {Value : Name}
    ]}
};
