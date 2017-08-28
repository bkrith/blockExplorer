
<div class="tableDiv">
        <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
            <thead>
              <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="2">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">view_carousel</i> Block #{{ @block.block }}</div>
                </th>
              </tr>
            </thead>
            <tbody> 
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Height</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.height }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Number Of Transactions</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.numberOfTransactions }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Total Amount</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.totalAmountNQT }} Burst</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Transaction Fees</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.totalFeeNQT }} Burst</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Timestamp</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.timestamp }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Generator</td>
                    <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @block.generator }}">{{ @block.generatorRS }}</a></td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Block Generation Time</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.generationTime }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Base Target</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.baseTarget }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Size</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.payloadLength }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Version</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.version }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Nonce</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.nonce }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Block Reward</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.blockReward }} Burst</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Block Signature</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.blockSignature }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Previous Block</td>
                    <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/block/{{ @block.previousBlock }}">{{ @block.previousBlock }}</a></td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Next Block</td>
                    <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/block/{{ @block.nextBlock }}">{{ @block.nextBlock }}</a></td>
                </tr>
            </tbody>
        </table>
    </div>

<check if = "{{ @block.numberOfTransactions > 0 }}">
    <true>
        <div class="tableDiv">
            <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
                <thead>
                    <tr>
                        <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="6">
                            <div class="tbHeaderDiv floatLeft"><i class="material-icons">swap_horiz</i> {{ @block.numberOfTransactions }} Transactions</div>
                        </th>
                    </tr>
                    <tr>
                        <th class="mdl-data-table__cell--non-numeric">ID</th>
                        <th class="mdl-data-table__cell--non-numeric">Sender</th>
                        <th class="mdl-data-table__cell--non-numeric">Recipient</th>
                        <th class="mdl-data-table__cell--non-numeric">Amount</th>
                        <th class="mdl-data-table__cell--non-numeric">Fee</th>
                        <th class="mdl-data-table__cell--non-numeric">Timestamp</th>
                    </tr>
                </thead>
                <tbody> 
                    <repeat group="{{ @block.transactions }}" value="{{ @transaction }}">
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/transaction/{{ @transaction.transaction }}">{{ @transaction.transaction }}</a></td>
                            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.sender }}">{{ @transaction.senderRS }}</a></td>
                            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.recipient }}">{{ @transaction.recipientRS }}</a></td>
                            <td class="mdl-data-table__cell--non-numeric">{{ @transaction.amountNQT }}</td>
                            <td class="mdl-data-table__cell--non-numeric">{{ @transaction.feeNQT }}</td>
                            <td class="mdl-data-table__cell--non-numeric">{{ @transaction.timestamp }}</td>
                        </tr>
                    </repeat>
                </tbody>
            </table>
        </div>
    </true>
    <false>
        <div class="tableDiv">
            <h6><strong>No Block Transactions</strong></h6>
        </div>
    </false>
</check>