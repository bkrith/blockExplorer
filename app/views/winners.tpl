
    <!-- div class="fixedIconDiv"><i class="material-icons">done_all</i></div -->
    <div class="winnersBackgroundDiv">
        <div class="mdl-layout-spacer"></div>
        <div class="cardInfo mdl-card mdl-shadow--2dp winnersTableDiv">
                <div class="mdl-card__title">
                    <h2 class="mdl-card__title-text mdl-shadow--2dp">{{ @countWinBlocks }} blocks today</h2>
                </div>
                <div class="mdl-card__supporting-text">
                    <p>
                        <i class="material-icons">dashboard</i>
                    </p>
                    <p>
                            <font color="#16a765">{{ @countWinBlocks }}</font> blocks today
                    </p>
                    <p>
                        Current block #<font color="#ff7537">{{ @blocks[0].height + 1 }}</font> <p><font color="#4986e7"><span id="countNext2"></span></font></p>
                    </p>
                    <p>
                        <span class="mdl-layout--large-screen-only showDate" id="clockbox2"></span>
                    </p>
                    <p>
                        <canvas id="myChart" width="600" height="300"></canvas>
                    </p>
                </div>
                <div class="mdl-card__menu mdl-shadow--2dp">
                    <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect">
                    <i class="material-icons">equalizer</i>
                    </button>
                </div>
        </div>
        <div class="mdl-layout-spacer"></div>
        <div class="winnersTableDiv winnersTopDiv">
            <div class="cardTop mdl-card mdl-shadow--2dp">
                <div class="mdl-card__title">
                    <h2 class="mdl-card__title-text mdl-shadow--2dp">Top 10 Pools</h2>
                </div>
                <div class="mdl-card__supporting-text">
                    <div class="demo-list-action mdl-list">
                        <repeat group="{{ @winners }}" value="{{ @winner }}" counter="{{ @ctr }}">
                            <div class="mdl-list__item">
                                <span class="mdl-list__item-primary-content">
                                        <span class="numberList{{ @winner.poolName == 'Solo Miner'?'1':@winner.pool }}">{{ @ctr }}</span>
                                <span class="coloredWinner{{ @winner.poolName == 'Solo Miner'?'1':@winner.pool }}">
                                        {{ @winner.poolName == 'Solo Miner'?'Solo Miners':@winner.poolName }}</span>
                                </span>
                                
                                <span class="mdl-list__item-secondary-content">
                                        <span class="coloredWinnerBlocks{{ @winner.poolName == 'Solo Miner'?'1':@winner.pool }}">{{ @winner.wins?@winner.wins . ' blocks':'0 blocks' }}</span>
                                </span>
                            </div>
                        </repeat>
                    </div>
                </div>
                <div class="mdl-card__menu mdl-shadow--2dp">
                    <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect">
                    <i class="material-icons">equalizer</i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="tableDiv">
        <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
            <thead>
              <tr>
                <th class="mdl-data-table__cell--non-numeric heightThTable">Block #</th>
                <th class="mdl-data-table__cell--non-numeric">Date</th>
                <th class="mdl-data-table__cell--non-numeric">NetDiff</th>
                <th class="mdl-data-table__cell--non-numeric">Deadline</th>
                <th class="mdl-data-table__cell--non-numeric">Block Reward / Fee</th>
                <th class="mdl-data-table__cell--non-numeric">Address / Name</th>
                <th class="mdl-data-table__cell--non-numeric">Pool Name</th>
              </tr>
            </thead>
            <tbody id="winnersTableBody"> 
                <repeat group="{{ @blocks }}" value="{{ @block }}">
                    <tr>
                        <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/block/{{ @block.blockId }}">{{ @block.height }}</a></td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.timestamp }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.netDiff }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.deadline }}</td>
                        <td class="mdl-data-table__cell--non-numeric">
                            <span id="winnerListReward{{ @block.height }}" class="underText">{{ @block.reward }}</span>
                            <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--right" for="winnerListReward{{ @block.height }}">
                                BTC: {{ @market['btc'] * str_replace("'", "", @block.reward) }}<br>
                                USD: {{ @market['usd'] * str_replace("'", "", @block.reward) }}<br>
                                EUR: {{ @market['eur'] * str_replace("'", "", @block.reward) }}
                            </div>
                            / 
                            <span id="winnerListFee{{ @block.height }}" class="underText">{{ @block.fee }}</span>
                            <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--right" for="winnerListFee{{ @block.height }}">
                                BTC: {{ @market['btc'] * str_replace("'", "", @block.fee) }}<br>
                                USD: {{ @market['usd'] * str_replace("'", "", @block.fee) }}<br>
                                EUR: {{ @market['eur'] * str_replace("'", "", @block.fee) }}
                            </div>
                        </td>
                        <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @block.generator }}">{{ @block.generatorName }}<br>{{ @block.generatorRS }}</a></td>
                        <td class="mdl-data-table__cell--non-numeric bold"><a class="winnerPoolLink" href="{{ @BASE }}/account/{{ @block.pool }}">{{ @block.poolName }}</a></td>
                    </tr>
                </repeat>
            </tbody>
        </table>
    </div>


<script>

    getNetDiff();

    function getNetDiff() {
        $.ajax({
            url: '/winners/netdiff',
            error: () => {
                console.log('no access to app api');
            },
            success: (blocksData) => {
                let blocks = JSON.parse(blocksData);
                
                let ctx = document.getElementById("myChart").getContext('2d');
                let myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: blocks['height'],
                    datasets: [{
                        label: 'Network Difficulty',
                        data: blocks['netDiff'],
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
            }
        });
    }

    function getColors() {
        $.ajax({
            url: '/winners/pool/names',
            error: () => {
                console.log('no access to app api');
            },
            success: (poolsData) => {
                let pools = JSON.parse(poolsData);
                
                pools.forEach(function (pool) {
                    if ($('.coloredWinner' + pool.pool).length) {
                        let str =  $('.coloredWinner' + pool.pool).html();
                        let str2 = $('.coloredWinnerBlocks' + pool.pool).html();
                        
                        if (localStorage.getItem(pool.pool)) {
                            $('.numberList' + pool.pool).css("background-color", localStorage.getItem(pool.pool));
                            $('.coloredWinner' + pool.pool).html('<strong>' + str.fontcolor(localStorage.getItem(pool.pool)) + '</strong>');
                            $('.coloredWinnerBlocks' + pool.pool).html(str2.fontcolor(localStorage.getItem(pool.pool)));
                        }
                        else {
                            $('.numberList' + pool.pool).css("background-color", pool.color);
                            $('.coloredWinner' + pool.pool).html('<strong>' + str.fontcolor(pool.color) + '</strong>');
                            $('.coloredWinnerBlocks' + pool.pool).html(str2.fontcolor(pool.color));
                        }
                    }
                });
            }
        });
    }

    $(document).ready(function () {
        getColors();
    });

</script>