
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
            <tbody> 
                <repeat group="{{ @blocks.blocks }}" value="{{ @block }}">
                    <tr>
                        <td class="mdl-data-table__cell--non-numeric {{ @block.bold }}"><a href="{{ @BASE }}/block/{{ @block.block }}">{{ @block.height }}</a></td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.timestamp }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.netDiff }} / {{ @block.generationTime }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.blockReward }} / {{ @block.totalFeeNQT }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.generatorName }}<br>{{ @block.generatorRS }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.poolName }}</td>
                        </tr>
                </repeat>
            </tbody>
        </table>
    </div>