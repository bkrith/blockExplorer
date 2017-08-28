
    <repeat group="{{ @blocks }}" value="{{ @block }}">
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