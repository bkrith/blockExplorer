
<div class="calcsDiv">
<div class="mdl-layout-spacer"></div>
<div class="miningCard mdl-card mdl-shadow--2dp">
    <div class="mdl-card__title">
        <h2 class="mdl-card__title-text">Mining Calculator</h2>
    </div>
    <div class="mdl-card__supporting-text">
        <form action="#">
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" value="{{ @blockReward }}" id="blockReward">
                <label class="mdl-textfield__label" for="blockReward">Block Reward</label>
                <span class="mdl-textfield__error">Input is not a number!</span>
            </div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" value="{{ @baseTarget }}" id="baseTarget">
                <label class="mdl-textfield__label" for="baseTarget">Base Target</label>
                <span class="mdl-textfield__error">Input is not a number!</span>
            </div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label totalPlotSizeDiv">
                <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="totalPlotSize">
                <label class="mdl-textfield__label" for="totalPlotSize">Plot Size</label>
                <span class="mdl-textfield__error">Input is not a number!</span>
            </div>
            <div class="plotSizeDiv">
                <button id="plotSize" class="mdl-button mdl-js-button">
                    TB
                </button>

                <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect plotSizeList" for="plotSize">
                    <li pSize="PB" class="mdl-menu__item">PB</li>
                    <li pSize="TB" class="mdl-menu__item">TB</li>
                    <li pSize="GB" class="mdl-menu__item">GB</li>
                </ul>
            </div>
        </form>
    </div>
    <div class="mdl-card__actions mdl-card--border">
        <canvas id="myChart" width="450" height="300"></canvas>
    </div>
    <div class="mdl-card__actions mdl-card--border">
        <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" id="miningBtn">
            Calculate
        </a>
    </div>
</div>


<div class="mdl-layout-spacer"></div>
<div class="calcCard mdl-card mdl-shadow--2dp">
    <div class="mdl-card__title">
        <h2 class="mdl-card__title-text">Price Calculator</h2>
    </div>
    <div class="mdl-card__supporting-text">
        <form action="#">
            <div class="currencyDiv ">
                <button id="currency" class="mdl-button mdl-js-button">
                    Burst
                </button>

                <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect currencyList" for="currency">
                    <li cur="Burst" class="mdl-menu__item">Burst</li>
                    <li cur="BTC" class="mdl-menu__item">BTC</li>
                    <li cur="USD" class="mdl-menu__item">USD</li>
                    <li cur="EUR" class="mdl-menu__item">EUR</li>
                </ul>
            </div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label floatRight">
                <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" value="1" id="amount">
                <label class="mdl-textfield__label" for="btcB">Amount</label>
                <span class="mdl-textfield__error">Input is not a number!</span>
            </div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" value="{{ @market['btc'] }}" id="btcB">
                <label class="mdl-textfield__label" for="btcB">BTC/Burst</label>
                <span class="mdl-textfield__error">Input is not a number!</span>
            </div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" value="{{ @market['usd'] }}" id="usdB">
                <label class="mdl-textfield__label" for="usdB">USD/Burst</label>
                <span class="mdl-textfield__error">Input is not a number!</span>
            </div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label clearDiv">
                <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" value="{{ @market['eur'] }}" id="eurB">
                <label class="mdl-textfield__label" for="eurB">EUR/Burst</label>
                <span class="mdl-textfield__error">Input is not a number!</span>
            </div>
        </form>

            <span class="mdl-chip mdl-chip--contact floatRight" id="burstR">
                <span class="mdl-chip__contact mdl-color--teal mdl-color-text--white">Burst</span>
                <span class="mdl-chip__text burstR">0</span>
            </span>
            <span class="mdl-chip mdl-chip--contact floatRight" id="btcR">
                <span class="mdl-chip__contact mdl-color--teal mdl-color-text--white">BTC</span>
                <span class="mdl-chip__text btcR">723.5</span>
            </span>
            <span class="mdl-chip mdl-chip--contact floatRight" id="usdR">
                <span class="mdl-chip__contact mdl-color--teal mdl-color-text--white">USD</span>
                <span class="mdl-chip__text usdR">723.5</span>
            </span>
            <span class="mdl-chip mdl-chip--contact floatRight" id="eurR">
                <span class="mdl-chip__contact mdl-color--teal mdl-color-text--white">EUR</span>
                <span class="mdl-chip__text eurR">723.5</span>
            </span>
    </div>
</div>
<div class="mdl-layout-spacer"></div>
</div>

<script>

    let currency = 'Burst';

    function prices() {
        let amount = $('#amount').val();
        let btc = parseFloat('{{ @market["btc"] }}');
        let usd = parseFloat('{{ @market["usd"] }}');
        let eur = parseFloat('{{ @market["eur"] }}');
        let temp = 0;

        if (currency == 'Burst') {
            $('.btcR').html((btc * amount).toFixed(8));
            $('.usdR').html((usd * amount).toFixed(8));
            $('.eurR').html((eur * amount).toFixed(8));
        }
        else if (currency == 'BTC') {
            temp = (1 / btc) * amount;
            
            $('.burstR').html(temp.toFixed(8));
            $('.usdR').html((usd * temp).toFixed(8));
            $('.eurR').html((eur * temp).toFixed(8));
        }
        else if (currency == 'USD') {
            temp = (1 / usd) * amount;
            
            $('.burstR').html(temp.toFixed(8));
            $('.btcR').html((btc * temp).toFixed(8));
            $('.eurR').html((eur * temp).toFixed(8));
        }
        else if (currency == 'EUR') {
            temp = (1 / eur) * amount;
            
            $('.burstR').html(temp.toFixed(8));
            $('.usdR').html((usd * temp).toFixed(8));
            $('.btcR').html((btc * temp).toFixed(8));
        }
    }

    prices();

    $('#amount').on('input', function () {
        prices();
    });

    $('#burstR').hide();

    $('#myChart').hide();

    let plotSize = 'TB';

    $('#miningBtn').on('click', function (e) {
        e.preventDefault();

        let baseTarget = $('#baseTarget').val();
        let blockReward = $('#blockReward').val();
        let f = 0.85;
        let pSize = 1;
        let day = 0;

        switch (plotSize) {
            case 'PB':
                pSize *= 1024;
            case 'TB':
                pSize *= 1024;
            case 'GB':
                pSize *= 1024;
        }

        day = 4 * parseFloat($("#totalPlotSize").val()) * pSize;
        day = Math.pow(2, 64) / baseTarget / day;
        blockReward = 3600 * blockReward / day;
        day = 24 * blockReward * f;

        let days = [];
        let amount = [];
        for (let i = 1; i <= 30; i++) {
            days.push(i);
            amount.push((i * day).toFixed(2));
        }

        $('#myChart').show();
        let ctx = document.getElementById("myChart").getContext('2d');
        let myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: days,
            datasets: [{
                label: 'Burst',
                data: amount,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                ],
                borderWidth: 1
            }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:false
                        }
                    }]
                }
            }
        });
    });

    $('.plotSizeList li').on('click', function (e) {
        plotSize = $(this).attr('pSize');
        $('#plotSize').html($(this).attr('pSize'));
    });

    $('#plotSize').on('click', function (e) {
        e.preventDefault();
    });

    $('.currencyList li').on('click', function (e) {
        currency = $(this).attr('cur');
        $('#currency').html(currency);

        if (currency == 'Burst') {
            $('#burstR').hide();
            $('#btcR').show();
            $('#usdR').show();
            $('#eurR').show();
        }
        else if (currency == 'BTC') {
        console.log(currency);

            $('#burstR').show();
            $('#btcR').hide();
            $('#usdR').show();
            $('#eurR').show();
        }
        else if (currency == 'USD') {
            $('#burstR').show();
            $('#btcR').show();
            $('#usdR').hide();
            $('#eurR').show();
        }
        else if (currency == 'EUR') {
            $('#burstR').show();
            $('#btcR').show();
            $('#usdR').show();
            $('#eurR').hide();
        }

        prices();
    });

    $('#currency').on('click', function (e) {
        e.preventDefault();
    });

</script>