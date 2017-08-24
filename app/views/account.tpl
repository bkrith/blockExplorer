
    <div class="tableDiv">
        <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
            <thead>
              <tr>
                <th class="mdl-data-table__cell--non-numeric blockThTable"><h6><strong>Account #{{ @account.account }}</strong></h6></th>
                <th class="mdl-data-table__cell--non-numeric"></th>
              </tr>
            </thead>
            <tbody> 
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Account</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.accountRS }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Numeric Account ID</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.account }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Public Key</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.publicKey }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Name</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.name }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Description</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.description }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Transactions</td>
                    <td class="mdl-data-table__cell--non-numeric">Last {{ @account.countTransactions }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Total Received</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.totalReceive }} Burst (last {{ @account.countTransactions }} transactions)</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Total Sent</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.totalSent }} Burst (last {{ @account.countTransactions }} transactions)</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric blockThTable">Balance</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.effectiveBalanceNXT }} Burst</td>
                </tr>
            </tbody>
        </table>
    </div>
    

<div class="tableDiv leftTable">
    <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
            <thead>
                <tr>
                    <th class="mdl-data-table__cell--non-numeric"><h6><strong>Forged Blocks</strong></h6></th>
                </tr>
            </thead>
            <tbody> 
                <repeat group="{{ @account.forgedBlocks }}" value="{{ @forged }}">
                    <tr>
                        <td class="mdl-data-table__cell--non-numeric">
                            <strong>Block <a href="{{ @BASE }}/block/{{ @forged.block }}">#{{ @forged.height }}</a></strong><br>
                            Reward: {{ @forged.blockReward }} Burst<br>
                            Fee: {{ @forged.totalFeeNQT }} Burst<br>
                            {{ @forged.timestamp }}
                        </td>
                    </tr>
                </repeat>
            </tbody>
    </table>
</div>
<div class="tableDiv rightTable">
<check if = "{{ @account.countTransactions > 0 }}">
    <true>
            <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
                <thead>
                    <tr>
                        <th class="mdl-data-table__cell--non-numeric" colspan="5"><h6><strong>{{ @account.countTransactions }} Transactions</strong></h6></th>
                    </tr>
                    <tr>
                        <th class="mdl-data-table__cell--non-numeric">ID</th>
                        <th class="mdl-data-table__cell--non-numeric">Sender</th>
                        <th class="mdl-data-table__cell--non-numeric">Amount</th>
                        <th class="mdl-data-table__cell--non-numeric">Recipient</th>
                        <th class="mdl-data-table__cell--non-numeric">Timestamp</th>
                    </tr>
                </thead>
                <tbody> 
                    <repeat group="{{ @account.transactions }}" value="{{ @transaction }}">
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/transaction/{{ @transaction.transaction }}">{{ @transaction.transaction }}</a></td>
                            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.sender }}">{{ @transaction.senderRS }}</a></td>
                            <check if = "{{ @transaction.move == 'green' }}">
                                <true>
                                    <td class="mdl-data-table__cell--non-numeric greenText boldText"><i class="material-icons">keyboard_arrow_right</i>{{ @transaction.amountNQT }} Burst</td>
                                </true>
                                <false>
                                    <td class="mdl-data-table__cell--non-numeric redText boldText"><i class="material-icons">keyboard_arrow_left</i>{{ @transaction.amountNQT }} Burst</td>
                                </false>
                            </check>
                            <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @transaction.recipient }}">{{ @transaction.recipientRS }}</a></td>
                            <td class="mdl-data-table__cell--non-numeric">{{ @transaction.timestamp }}</td>
                        </tr>
                    </repeat>
                </tbody>
            </table>
    </true>
    <false>
            <h6><strong>No Block Transactions</strong></h6>
    </false>
</check>
</div>