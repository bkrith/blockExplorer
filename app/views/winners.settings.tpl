
<div class="settingsDiv">
    <h5 class="classicColor">Change the Pool Colors</h5>
    <span>Pool colors: </span> 
    <select name="colorpicker-longlist">
        <option value="#ac725e">#ac725e</option>
        <option value="#d06b64">#d06b64</option>
        <option value="#f83a22">#f83a22</option>
        <option value="#fa573c">#fa573c</option>
        <option value="#ff7537">#ff7537</option>
        <option value="#ffad46">#ffad46</option>
        <option value="#42d692">#42d692</option>
        <option value="#16a765">#16a765</option>
        <option value="#7bd148">#7bd148</option>
        <option value="#b3dc6c">#b3dc6c</option>
        <option value="#fbe983">#fbe983</option>
        <option value="#fad165">#fad165</option>
        <option value="#92e1c0">#92e1c0</option>
        <option value="#9fe1e7">#9fe1e7</option>
        <option value="#9fc6e7">#9fc6e7</option>
        <option value="#4986e7">#4986e7</option>
        <option value="#9a9cff">#9a9cff</option>
        <option value="#b99aff">#b99aff</option>
        <option value="#c2c2c2">#c2c2c2</option>
        <option value="#cabdbf">#cabdbf</option>
        <option value="#cca6ac">#cca6ac</option>
        <option value="#f691b2">#f691b2</option>
        <option value="#cd74e6">#cd74e6</option>
        <option value="#a47ae2">#a47ae2</option>
    </select>
    <button id="selectPool" poolSelection="" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--primary">
            Select Pool
    </button>
    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect" for="selectPool">
        <repeat group="{{ @pools }}" value="{{ @pool }}" counter="{{ @ctr }}">
            <li id="poolNameLink{{ @ctr }}" class="mdl-menu__item mdl-menu__item--full-bleed-divider" name="{{ @pool.poolName }}">{{ @pool.poolName }}</li>
        </repeat>
    </ul>
    <button id="submitColor" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--accent">
        Change it!
    </button>
</div>
<div class="tableDiv">
        <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
            <thead>
              <tr>
                <th class="mdl-data-table__cell--non-numeric">Pool</th>
              </tr>
            </thead>
            <tbody> 
                <repeat group="{{ @pools }}" value="{{ @pool }}" counter="{{ @ctr }}">
                    <tr>
                        <td id="sampleText{{ @ctr }}" class="mdl-data-table__cell--non-numeric"><strong>{{ @pool.poolName }}</strong></td>
                    </tr>
                </repeat>
            </tbody>
        </table>
</div>

<script>

    $(document).ready(function () {
        $('select[name="colorpicker-longlist"]').simplecolorpicker({theme: 'regularfont'});
        getColors();
    });

    $("li[id^=poolNameLink]").click(function () {
        $('#selectPool').html($(this).attr('name'));
        $('#selectPool').attr('poolSelection', $(this).attr('name'));
    });

    $("#submitColor").click(function () {
        if ($('#selectPool').attr('poolSelection') != '') {
            localStorage.setItem($('#selectPool').html(), $('select[name="colorpicker-longlist"]').val());
        }
        getColors();
    });

    function getColors() {
        let poolNames = null;

        $.ajax({
            url: '/winners/pool/names',
            error: () => {
                console.log('no access to app api');
            },
            success: (pools) => {
                poolNames = JSON.parse(pools);

                let i = 1;

                poolNames.forEach(function(pool) {
                        console.log(pool.poolName);
                        console.log(localStorage.getItem(pool.poolName));
                    if (localStorage.getItem(pool.poolName)) {
                        let str = pool.poolName;
                        $('#sampleText' + i).html('<strong>' + str.fontcolor(localStorage.getItem(pool.poolName)) + '</strong>');
                    }
                    i++;
                });
            }
        });
    }

</script>