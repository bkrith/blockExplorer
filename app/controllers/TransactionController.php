
<?php

    class TransactionController {

        function transaction($f3) {
            $transaction = new Transaction($f3);

            $id = $f3->get('PARAMS.transaction');
            $f3->set('transaction', $transaction->getTransaction($id));

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            if ($f3->get('transaction')) echo \Template::instance()->render('transaction.tpl');
            else echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

    }