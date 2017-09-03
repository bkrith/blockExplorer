
<?php

    class TransactionController {

        function transaction($f3) {
            $transaction = new Transaction();

            $id = $f3->get('PARAMS.transaction');
            $f3->set('transaction', $transaction->getTransaction($id));
            $f3->set('title', $f3->get('mainTitle') . ' ::  Transaction ' . $f3->get('transaction')['transaction']);

            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->find(null, array('limit' => 1))[0];

            $f3->set('market', $marketValues);

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            if ($f3->get('transaction')) echo \Template::instance()->render('transaction.tpl');
            else echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function transactions($f3) {
            $transactions = new Transaction();

            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->find(null, array('limit' => 1))[0];

            $f3->set('market', $marketValues);

            $page = $f3->get('PARAMS.page');
            $account = $f3->get('PARAMS.account');
            $f3->set('transactions', $transactions->getTransactionPage($account, $page)['transactions']);
            
            echo \Template::instance()->render('transactions.tpl');
        }

    }