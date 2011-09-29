Ext.regModel('ContentObject', {
    fields: [
        {name: 'objectName', type: 'string'},
        {name: 'objectId', type: 'string'},
        {name: 'nodeId', type: 'string'}
    ]
});

Ext.setup({
    onReady: function() {
        var store = new Ext.data.TreeStore({
            autoLoad: false,
            model: 'ContentObject',
            proxy: {
                type: 'ajax',
                url: '/api/ezp/content/node/2/list',
                reader: {
                    type: 'tree',
                    root: 'childrenNodes'
                }
            }
        });

        var nestedList = new Ext.NestedList({
            fullscreen: true,
            title: 'List',
            displayField: 'objectName',
            store: store
        });

        nestedList.on('itemtap', function(subList, subIdx, el, e) {
            var ds = subList.getStore(),
                r  = ds.getAt(subIdx);

            store.proxy.url = '/api/ezp/content/node/' + r.get('nodeId') + '/list';
        });
    }
});
