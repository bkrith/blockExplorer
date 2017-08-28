
<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp blockDataTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="8">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">view_day</i> Blocks</div>
                    <div class="mdl-paging tbHeaderPagination floatLeft">
                        <a id="previousBlockPage" disabled="true" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__previous"><i class="material-icons">keyboard_arrow_left</i>
                        </a>
                        <a id="nextBlockPage" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__next"><i class="material-icons">keyboard_arrow_right</i>
                        </a>
                    </div>
                    <div class="mdl-paging tbHeaderPagination floatRight">
                        <a id="firstBlockPage" disabled="true" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__first"><i class="material-icons">arrow_back</i>
                        </a>
                        <a id="lastBlockPage" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__last"><i class="material-icons">arrow_forward</i>
                        </a>
                    </div>
                </th>
            </tr>
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
        <tbody id="blocksTableBody"> 
            <repeat group="{{ @blocks }}" value="{{ @block }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric heightThTable {{ @block.bold }}"><a href="{{ @BASE }}/block/{{ @block.block }}">{{ @block.height }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.timestamp }}</td>
                    <td class="mdl-data-table__cell--non-numeric transactionsThTable">{{ @block.numberOfTransactions }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.totalAmountNQT }}</td>
                    <td class="mdl-data-table__cell--non-numeric feeThTable">{{ @block.totalFeeNQT }}</td>
                    <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @block.generator }}">{{ @block.generatorRS }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric payloadThTable">{{ @block.payloadLength }}</td>
                    <td class="mdl-data-table__cell--non-numeric baseTargetThTable">{{ @block.baseTarget }}</td>
                    </tr>
            </repeat>
        </tbody>
    </table>
</div>


<script>
    let BlockPage = 1;
    let maxBlockPage = parseInt(parseInt("{{ @blocks[0].height }}") / 100);
    if (maxBlockPage < parseInt("{{ @blocks[0].height }}")) maxBlockPage++;

console.log(maxBlockPage);

    $(document).ready(() => {
        disableBlockNav();
    });

    // Transaction Navigation

    $('#previousBlockPage').on('click', (event) => {
        event.preventDefault();

        if (!$('#previousBlockPage').attr('disabled')) {
            disableBlockNav(true);
            $.ajax({
                url: '/blocks/page/' + (BlockPage - 1),
                datatype: 'html',
                error: () => {
                    console.log('no access to app api');
                },
                success: (html) => {
                    $('#blocksTableBody').html(html);
                    BlockPage--;
                    disableBlockNav();
                }
            });
        }
    });

    $('#nextBlockPage').on('click', (event) => {
        event.preventDefault();

        if (!$('#nextBlockPage').attr('disabled')) {
            disableBlockNav(true);
            $.ajax({
                url: '/blocks/page/' + (BlockPage + 1),
                datatype: 'html',
                error: () => {
                    console.log('no access to app api');
                },
                success: (html) => {
                    $('#blocksTableBody').html(html);
                    BlockPage++;
                    disableBlockNav();
                }
            });
        }
    });

    $('#firstBlockPage').on('click', (event) => {
        event.preventDefault();

        if (!$('#firstBlockPage').attr('disabled')) {
            disableBlockNav(true);
            $.ajax({
                url: '/blocks/page/1',
                datatype: 'html',
                error: () => {
                    console.log('no access to app api');
                },
                success: (html) => {
                    $('#blocksTableBody').html(html);
                    BlockPage = 1;
                    disableBlockNav();
                }
            });
        }
    });

    $('#lastBlockPage').on('click', (event) => {
        event.preventDefault();

        if (!$('#lastBlockPage').attr('disabled')) {
            disableBlockNav(true);
            $.ajax({
                url: '/blocks/page/' + maxBlockPage,
                datatype: 'html',
                error: () => {
                    console.log('no access to app api');
                },
                success: (html) => {
                    $('#blocksTableBody').html(html);
                    BlockPage = maxBlockPage;
                    disableBlockNav();
                }
            });
        }
    });

    // Util functions

    let disableBlockNav = (alls = false) => {
        if (alls) {
            $('#firstBlockPage').attr('disabled', true);
            $('#previousBlockPage').attr('disabled', true);
            $('#nextBlockPage').attr('disabled', true);
            $('#lastBlockPage').attr('disabled', true);
        }
        else {
            if (BlockPage < 2) {
                $('#firstBlockPage').attr('disabled', true);
                $('#previousBlockPage').attr('disabled', true);
                $('#nextBlockPage').attr('disabled', false);
                $('#lastBlockPage').attr('disabled', false);
            }
            else if (BlockPage < maxBlockPage) {
                $('#firstBlockPage').attr('disabled', false);
                $('#previousBlockPage').attr('disabled', false);
                $('#nextBlockPage').attr('disabled', false);
                $('#lastBlockPage').attr('disabled', false);
            }
            else {
                $('#firstBlockPage').attr('disabled', false);
                $('#previousBlockPage').attr('disabled', false);
                $('#nextBlockPage').attr('disabled', true);
                $('#lastBlockPage').attr('disabled', true);
            }
        }
    }

</script>
