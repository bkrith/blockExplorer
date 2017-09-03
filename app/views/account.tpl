
    <div class="tableDiv">
        <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
            <thead>
                <tr>
                    <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="2">
                        <div class="tbHeaderDiv floatLeft"><i class="material-icons">person</i> Account #{{ @account.account }}</div>
                    </th>
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
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.countTransactions }}</td>
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
                    <th class="mdl-data-table__cell--non-numeric tbHeader">
                            <div class="tbHeaderDiv"><i class="material-icons">view_day</i> Forged Blocks</div>
                    </th>
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
                        <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="5">
                            <div class="tbHeaderDiv floatLeft"><i class="material-icons">swap_horiz</i> {{ @account.countTransactions }} Transactions</div>
                            <div class="mdl-paging tbHeaderPagination floatLeft">
                                <a id="previousTransactionPage" disabled="true" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__previous"><i class="material-icons">keyboard_arrow_left</i>
                                </a>
                                <a id="nextTransactionPage" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__next"><i class="material-icons">keyboard_arrow_right</i>
                                </a>
                            </div>
                            <div class="mdl-paging tbHeaderPagination floatRight">
                                <a id="firstTransactionPage" disabled="true" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__first"><i class="material-icons">arrow_back</i>
                                </a>
                                <a id="lastTransactionPage" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__last"><i class="material-icons">arrow_forward</i>
                                </a>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <th class="mdl-data-table__cell--non-numeric">ID</th>
                        <th class="mdl-data-table__cell--non-numeric">Sender</th>
                        <th class="mdl-data-table__cell--non-numeric">Amount</th>
                        <th class="mdl-data-table__cell--non-numeric">Recipient</th>
                        <th class="mdl-data-table__cell--non-numeric">Timestamp</th>
                    </tr>
                </thead>
                <tbody id="transactionsTableBody"> 
                    <repeat group="{{ @account.transactions }}" value="{{ @transaction }}">
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
                </tbody>
            </table>
    </true>
    <false>
            <h6><strong>No Block Transactions</strong></h6>
    </false>
</check>
</div>


<script>
    let transactionPage = 1;
    let maxTransactionPage = parseInt(parseInt('{{ @account.countTransactions }}') / 20);
    if (maxTransactionPage < parseInt('{{ @account.countTransactions }}')) maxTransactionPage++;


    $(document).ready(() => {
        disableTransactionNav();
    });

    // Transaction Navigation

    $('#previousTransactionPage').on('click', (event) => {
        event.preventDefault();

        if (!$('#previousTransactionPage').attr('disabled')) {
            disableTransactionNav(true);
            $.ajax({
                url: '/account/{{ @account.account }}/transactions/page/' + (transactionPage - 1),
                datatype: 'html',
                error: () => {
                    console.log('no access to app api');
                },
                success: (html) => {
                    $('#transactionsTableBody').html(html);
                    transactionPage--;
                    disableTransactionNav();
                    componentHandler.upgradeAllRegistered();
                }
            });
        }
    });

    $('#nextTransactionPage').on('click', (event) => {
        event.preventDefault();

        if (!$('#nextTransactionPage').attr('disabled')) {
            disableTransactionNav(true);
            $.ajax({
                url: '/account/{{ @account.account }}/transactions/page/' + (transactionPage + 1),
                datatype: 'html',
                error: () => {
                    console.log('no access to app api');
                },
                success: (html) => {
                    $('#transactionsTableBody').html(html);
                    transactionPage++;
                    disableTransactionNav();
                    componentHandler.upgradeAllRegistered();
                }
            });
        }
    });

    $('#firstTransactionPage').on('click', (event) => {
        event.preventDefault();

        if (!$('#firstTransactionPage').attr('disabled')) {
            disableTransactionNav(true);
            $.ajax({
                url: '/account/{{ @account.account }}/transactions/page/1',
                datatype: 'html',
                error: () => {
                    console.log('no access to app api');
                },
                success: (html) => {
                    $('#transactionsTableBody').html(html);
                    transactionPage = 1;
                    disableTransactionNav();
                    componentHandler.upgradeAllRegistered();
                }
            });
        }
    });

    $('#lastTransactionPage').on('click', (event) => {
        event.preventDefault();

        if (!$('#lastTransactionPage').attr('disabled')) {
            disableTransactionNav(true);
            $.ajax({
                url: '/account/{{ @account.account }}/transactions/page/' + maxTransactionPage,
                datatype: 'html',
                error: () => {
                    console.log('no access to app api');
                },
                success: (html) => {
                    $('#transactionsTableBody').html(html);
                    transactionPage = maxTransactionPage;
                    disableTransactionNav();
                    componentHandler.upgradeAllRegistered();
                }
            });
        }
    });

    // Util functions

    let disableTransactionNav = (alls = false) => {
        if (alls) {
            $('#firstTransactionPage').attr('disabled', true);
            $('#previousTransactionPage').attr('disabled', true);
            $('#nextTransactionPage').attr('disabled', true);
            $('#lastTransactionPage').attr('disabled', true);
        }
        else {
            if (transactionPage < 2) {
                $('#firstTransactionPage').attr('disabled', true);
                $('#previousTransactionPage').attr('disabled', true);
                $('#nextTransactionPage').attr('disabled', false);
                $('#lastTransactionPage').attr('disabled', false);
            }
            else if (transactionPage < maxTransactionPage) {
                $('#firstTransactionPage').attr('disabled', false);
                $('#previousTransactionPage').attr('disabled', false);
                $('#nextTransactionPage').attr('disabled', false);
                $('#lastTransactionPage').attr('disabled', false);
            }
            else {
                $('#firstTransactionPage').attr('disabled', false);
                $('#previousTransactionPage').attr('disabled', false);
                $('#nextTransactionPage').attr('disabled', true);
                $('#lastTransactionPage').attr('disabled', true);
            }
        }
    }

</script>
