
<?php

    class AccountController {

        function account($f3) {
            $account = new Account();

            $id = $f3->get('PARAMS.account');
            $f3->set('account', $account->getAccount($id));
            $f3->set('title', $f3->get('mainTitle') . ' :: Account ' . $f3->get('account')['account']);

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            if ($f3->get('account')) echo \Template::instance()->render('account.tpl');
            else echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

    }