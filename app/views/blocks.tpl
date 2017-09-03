
    <repeat group="{{ @blocks }}" value="{{ @block }}">
        <tr>
            <td class="mdl-data-table__cell--non-numeric {{ @block.bold }}"><a href="{{ @BASE }}/block/{{ @block.block }}">{{ @block.height }}</a></td>
            <td class="mdl-data-table__cell--non-numeric">{{ @block.timestamp }}</td>
            <td class="mdl-data-table__cell--non-numeric">{{ @block.numberOfTransactions }}</td>
            <td class="mdl-data-table__cell--non-numeric">
                    <span class="underText" id="blockListTotalAmountNQT{{ @block.height }}">{{ @block.totalAmountNQT }}</span>
                    <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--right" for="blockListTotalAmountNQT{{ @block.height }}">
                        BTC: {{ @market['btc'] * str_replace("'", "", @block.totalAmountNQT) }}<br>
                        USD: {{ @market['usd'] * str_replace("'", "", @block.totalAmountNQT) }}<br>
                        EUR: {{ @market['eur'] * str_replace("'", "", @block.totalAmountNQT) }}
                    </div>
            </td>
            <td class="mdl-data-table__cell--non-numeric">
                    <span class="underText" id="blockListTotalFeeNQT{{ @block.height }}">{{ @block.totalFeeNQT }}</span>
                    <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--right" for="blockListTotalFeeNQT{{ @block.height }}">
                        BTC: {{ @market['btc'] * str_replace("'", "", @block.totalFeeNQT) }}<br>
                        USD: {{ @market['usd'] * str_replace("'", "", @block.totalFeeNQT) }}<br>
                        EUR: {{ @market['eur'] * str_replace("'", "", @block.totalFeeNQT) }}
                    </div>
            </td>
            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @block.generator }}">{{ @block.generatorRS }}</a></td>
            <td class="mdl-data-table__cell--non-numeric">{{ @block.payloadLength }}</td>
            <td class="mdl-data-table__cell--non-numeric">{{ @block.baseTarget }}</td>
            </tr>
    </repeat>