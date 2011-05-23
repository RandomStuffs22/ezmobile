  <div id="header-position">
  <div id="header" class="float-break">
    <div id="usermenu">
      {include uri='design:page_header_languages.tpl'}
  
      {include uri='design:page_header_links.tpl'}
    </div>

    <div class="grid">
        <div class="unit-1-4">
        {def $current_node = fetch( 'content', 'node', hash( node_id, $current_node_id ))}
        {if and( ne( $current_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ), $current_node)}
            <div id="backbutton">
                <a href="{$current_node.parent.url_alias|ezurl( 'no' ))}"><img src="{'back.png'|ezimage( 'no' )}" /></a>
            </div>
        {/if}
        {undef $current_node}
        </div>
        <div class="unit-3-4">
            {include uri='design:page_header_logo.tpl'}
        </div>
    </div>

    {include uri='design:page_header_searchbox.tpl'}

    <p class="hide"><a href="#main">{'Skip to main content'|i18n('design/ezwebin/pagelayout')}</a></p>
  </div>
  </div>
