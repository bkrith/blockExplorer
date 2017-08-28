
    <div class="winnersBackgroundDiv">
        <div class="mdl-layout-spacer"></div>
        <div class="winnersTableDiv mdl-shadow--2dp winnersTopDiv">
            <repeat group="{{ @winners }}" value="{{ @winner }}" counter="{{ @ctr }}">
                <div class="clearDiv floatLeft {{ @ctr == 1?'firstWinner':'' }} {{ (@ctr > 1 && @ctr < 4)?'restWinners':'' }}">
                    {{ @ctr }}. {{ @winner.poolName == 'Solo Miner'?'Solo Miners':@winner.poolName }}
                </div>
                <div class="floatRight {{ @ctr == 1?'firstWinner':'' }} {{ (@ctr > 1 && @ctr < 4)?'restWinners':'' }}">
                    {{ @winner.wins }} blocks
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
                <th class="mdl-data-table__cell--non-numeric">NetDiff / DL</th>
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
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.netDiff }} / {{ @block.deadline }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.reward }} / {{ @block.fee }}</td>
                        <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @block.generator }}">{{ @block.generatorName }}<br>{{ @block.generatorRS }}</a></td>
                        <td class="mdl-data-table__cell--non-numeric bold"><a class="winnerPoolLink" href="{{ @BASE }}/account/{{ @block.pool }}">{{ @block.poolName }}</a></td>
                    </tr>
                </repeat>
            </tbody>
        </table>
    </div>