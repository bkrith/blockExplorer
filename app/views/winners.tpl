
    <div class="winnersBackgroundDiv">
        <div class="mdl-layout-spacer"></div>
        <div class="winnersTableDiv mdl-shadow--2dp winnersTopDiv">
            <repeat group="{{ @winners }}" value="{{ @winner }}" counter="{{ @ctr }}">
                <div class="clearDiv floatLeft">
                    <span class="coloredWinner{{ @ctr }}">{{ @ctr }}. {{ @winner.poolName == 'Solo Miner'?'Solo Miners':@winner.poolName }}</span>
                </div>
                <div class="floatRight">
                    <span class="coloredWinnerBlocks{{ @ctr }}">{{ @winner.wins?@winner.wins . ' blocks':'0 blocks' }}</span>
                </div>
            </repeat>
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
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.reward }} / {{ @block.fee }}</td>
                        <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @block.generator }}">{{ @block.generatorName }}<br>{{ @block.generatorRS }}</a></td>
                        <td class="mdl-data-table__cell--non-numeric bold"><a class="winnerPoolLink" href="{{ @BASE }}/account/{{ @block.pool }}">{{ @block.poolName }}</a></td>
                    </tr>
                </repeat>
            </tbody>
        </table>
    </div>


<script>

    function getColors() {
        let poolNames = null;

        $.ajax({
            url: '/winners/top',
            error: () => {
                console.log('no access to app api');
            },
            success: (pools) => {
                poolNames = JSON.parse(pools);

                let i = 1;

                poolNames.forEach(function(pool) {
                    if (localStorage.getItem(pool.poolName)) {
                        let str =  i + '. ' + pool.poolName;
                        $('.coloredWinner' + i).html('<strong>' + str.fontcolor(localStorage.getItem(pool.poolName)) + '</strong>');
                        let str2 = $('.coloredWinnerBlocks' + i).html();
                        $('.coloredWinnerBlocks' + i).html(str2.fontcolor(localStorage.getItem(pool.poolName)));
                    }
                    i++;
                });
            }
        });
    }

    $(document).ready(function () {
        getColors();
    });

</script>