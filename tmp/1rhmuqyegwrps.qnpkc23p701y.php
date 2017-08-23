
<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
        <thead>
          <tr>
            <th class="mdl-data-table__cell--non-numeric blockThTable"><h6><strong>Transaction #<?= $transaction['transaction'] ?></strong></h6></th>
            <th class="mdl-data-table__cell--non-numeric"></th>
          </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Sender</td>
                <td class="mdl-data-table__cell--non-numeric"><a href="<?= $BASE ?>/account/<?= $transaction['sender'] ?>"><?= $transaction['senderRS'] ?></a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Recipient</td>
                <td class="mdl-data-table__cell--non-numeric"><a href="<?= $BASE ?>/account/<?= $transaction['recipient'] ?>"><?= $transaction['recipientRS'] ?></a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Amount</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['amountNQT'] ?> Burst</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Fee</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['feeNQT'] ?> Burst</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Block</td>
                <td class="mdl-data-table__cell--non-numeric"><a href="<?= $BASE ?>/block/<?= $transaction['block'] ?>"><?= $transaction['block'] ?></a> / <a href="<?= $BASE ?>/height/<?= $transaction['height'] ?>"><?= $transaction['height'] ?></a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Type</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['type'] ?></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Message</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['attachment']['message'] ?></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">MessageIsText</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['attachment']['messageIsText'] ?></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Version.Message</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['attachment']['version.Message'] ?></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Confirmations</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['confirmations'] ?></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Timestamp</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['timestamp'] ?></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Signature</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['signature'] ?></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Signature Hash</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['signatureHash'] ?></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Full Hash</td>
                <td class="mdl-data-table__cell--non-numeric"><?= $transaction['fullHash'] ?></td>
            </tr>
        </tbody>
    </table>
</div>
