{set scope=global persistent_variable=hash('left_menu', false(),
                                           'extra_menu', false(),
                                           'show_path', false(),
                                           'top_menu', false())}
<div class="grid">
    <div class="unit-1-2">
        <div class="category">
            <a href="{'/Recipes'|ezurl( 'no' )}"><img src="{'recipes.png'|ezimage( 'no' )}" /></a>
            <h2>{'Recipes'|i18n('desing/mobile/frontpage')}</h2>
        </div>
    </div>
    <div class="unit-1-2">
        <div class="category">
            <a href="{'/Food-reviews'|ezurl( 'no' )}"><img src="{'food-reviews.png'|ezimage( 'no' )}" /></a>
            <h2>{'Food reviews'|i18n('desing/mobile/frontpage')}</h2>
        </div>
    </div>
</div>

<div class="grid">
    <div class="unit-1-2">
        <div class="category">
            <a href="{'/Menus'|ezurl( 'no' )}"><img src="{'menus.png'|ezimage( 'no' )}" /></a>
            <h2>{'Menus'|i18n('desing/mobile/frontpage')}</h2>
        </div>
    </div>
    <div class="unit-1-2">
        <div class="category">
            <a href="{'/content/search'|ezurl( 'no' )}"><img src="{'search.png'|ezimage( 'no' )}" /></a>
            <h2>{'Search'|i18n('desing/mobile/frontpage')}</h2>
        </div>
    </div>
</div>
