    
    <repeat group="{{ @transactions }}" value="{{ @transaction }}">
        <tr>
            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/transaction/{{ @transaction.transaction }}">{{ @transaction.transaction }}</a></td>
            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.sender }}">{{ @transaction.senderRS }}</a></td>
            <td class="mdl-data-table__cell--non-numeric {{ @transaction.move }} boldText">
                <div class="floatLeft">
                    <check if = "{{ @transaction.move == 'greenText' }}">
                        <i class="material-icons">add</i>
                    </check>
                    <check if = "{{ @transaction.move == 'redText' }}">
                        <i class="material-icons">remove</i>
                    </check>
                </div>
                <div class="floatRight">
                    <span class="underText" id="transactionAmountNQT{{ @transaction.transaction }}">{{ @transaction.amountNQT }} Burst</span>
                    <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--right" for="transactionAmountNQT{{ @transaction.transaction }}">
                        BTC: {{ @market['btc'] * str_replace("'", "", @transaction.amountNQT) }}<br>
                        USD: {{ @market['usd'] * str_replace("'", "", @transaction.amountNQT) }}<br>
                        EUR: {{ @market['eur'] * str_replace("'", "", @transaction.amountNQT) }}
                    </div>
                </div>
            </td>
            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.recipient }}">{{ @transaction.recipientRS }}</a></td>
            <td class="mdl-data-table__cell--non-numeric">{{ @transaction.timestamp }}</td>
        </tr>
    </repeat>