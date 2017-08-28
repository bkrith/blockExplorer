    
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
                    {{ @transaction.amountNQT }} Burst
                </div>
            </td>
            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.recipient }}">{{ @transaction.recipientRS }}</a></td>
            <td class="mdl-data-table__cell--non-numeric">{{ @transaction.timestamp }}</td>
        </tr>
    </repeat>