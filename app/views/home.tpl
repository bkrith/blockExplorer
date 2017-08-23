
<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
        <thead>
          <tr>
            <th class="mdl-data-table__cell--non-numeric heightThTable">Height</th>
            <th class="mdl-data-table__cell--non-numeric">Date</th>
            <th class="mdl-data-table__cell--non-numeric transactionsThTable">Transactions</th>
            <th class="mdl-data-table__cell--non-numeric">Amount</th>
            <th class="mdl-data-table__cell--non-numeric feeThTable">Fee</th>
            <th class="mdl-data-table__cell--non-numeric">Generator</th>
            <th class="mdl-data-table__cell--non-numeric payloadThTable">Size</th>
            <th class="mdl-data-table__cell--non-numeric baseTargetThTable">Base Target</th>
          </tr>
        </thead>
        <tbody> 
            <repeat group="{{ @blocks.blocks }}" value="{{ @block }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric {{ @block.bold }}"><a href="{{ @BASE }}/block/{{ @block.block }}">{{ @block.height }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.timestamp }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.numberOfTransactions }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.totalAmountNQT }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.totalFeeNQT }}</td>
                    <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @block.generator }}">{{ @block.generatorRS }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.payloadLength }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.baseTarget }}</td>
                    </tr>
            </repeat>
        </tbody>
    </table>
</div>