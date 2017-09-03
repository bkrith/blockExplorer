
<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="2">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">swap_horiz</i> Transaction #{{ @transaction.transaction }}</div>
                </th>
            </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Sender</td>
                <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.sender }}">{{ @transaction.senderRS }}</a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Recipient</td>
                <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.recipient }}">{{ @transaction.recipientRS }}</a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Amount</td>
                <td class="mdl-data-table__cell--non-numeric">
                        <span class="underText" id="transactionAmountNQT{{ @transaction.transaction }}">{{ @transaction.amountNQT }} Burst</span>
                        <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--right" for="transactionAmountNQT{{ @transaction.transaction }}">
                            BTC: {{ @market['btc'] * str_replace("'", "", @transaction.amountNQT) }}<br>
                            USD: {{ @market['usd'] * str_replace("'", "", @transaction.amountNQT) }}<br>
                            EUR: {{ @market['eur'] * str_replace("'", "", @transaction.amountNQT) }}
                        </div>
                </td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Fee</td>
                <td class="mdl-data-table__cell--non-numeric">
                        <span class="underText" id="transactionFeeNQT{{ @transaction.transaction }}">{{ @transaction.feeNQT }} Burst</span>
                        <div class="mdl-tooltip mdl-tooltip--large mdl-tooltip--right" for="transactionFeeNQT{{ @transaction.transaction }}">
                            BTC: {{ @market['btc'] * str_replace("'", "", @transaction.feeNQT) }}<br>
                            USD: {{ @market['usd'] * str_replace("'", "", @transaction.feeNQT) }}<br>
                            EUR: {{ @market['eur'] * str_replace("'", "", @transaction.feeNQT) }}
                        </div>
                </td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Block</td>
                <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/block/{{ @transaction.block }}">{{ @transaction.block }}</a> / <a href="{{ @BASE }}/height/{{ @transaction.height }}">{{ @transaction.height }}</a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Type</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.type }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Message</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.attachment.message }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">MessageIsText</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.attachment.messageIsText }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Version.Message</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.attachment['version.Message'] }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Confirmations</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.confirmations }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Timestamp</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.timestamp }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Signature</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.signature }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Signature Hash</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.signatureHash }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Full Hash</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.fullHash }}</td>
            </tr>
        </tbody>
    </table>
</div>
