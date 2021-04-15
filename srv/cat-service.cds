using my.bookshop as my from '../db/data-model';

service CatalogService @(requires: 'authenticated-user') {
    entity Books as projection on my.Books;
}

annotate CatalogService.Books with @(
    restrict: [
        { grant: ['WRITE'], to: ['authenticated-user'] },
        { grant: ['READ'], where: 'createdBy = $user'}
    ]
);

annotate CatalogService.Books with @(
    UI : {
        HeaderInfo: {
            TypeName: 'Book',
            TypeNamePlural: 'Books',
            Title: { Value: ID },
            Description: { Value: title }
        },
        SelectionFields  : [
            title
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            }, 
            {
                $Type : 'UI.DataField',
                Value : stock,
            }                                   
        ],
        Identification : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            }, 
            {
                $Type : 'UI.DataField',
                Value : stock,
            }              
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Book Info',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Main', Label: 'Main Facet'}
                ]
            }
        ],
        FieldGroup#Main: {
            Data: [
                { Label : 'ID', Value: ID },
                { Label : 'Title', Value: title },
                { Label : 'Stock', Value: stock }
            ]
        }
     }
){
    ID @( title: 'ID' );    
    title @( title: 'Title' );
    stock @( title: 'Stock' );
};