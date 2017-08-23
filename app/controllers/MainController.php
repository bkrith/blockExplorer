
<?php

    class MainController {

        function home($f3) {
            $page = $f3->get('PARAMS.page');
            if ($page <= 0) {
                $page = 1;
                $previousPage = 1;
            }
            else {
                $previousPage = $page - 1;
            }

            $blocks = new Block($f3);
            $f3->set('blocks', $blocks->all($page));

            $maxBlock = $blocks->getLastBlock();
            $lastPage = intval($maxBlock / 100);
            if ($lastPage < ($maxBlock / 100)) $lastPage = $lastPage + 1;

            if ($page >= $lastPage) {
                $page = $lastPage;
            }
            else {
                $nextPage = $page + 1;
            }

            $f3->set('previousPage', $previousPage);
            $f3->set('nextPage', $nextPage);
            $f3->set('lastPage', $lastPage);

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('pagination.tpl');
            echo \Template::instance()->render('home.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function search($f3) {
            $search = $f3->get('PARAMS.search');
            $item = $f3->get('PARAMS.item');
            if ($item == 'block') {
                $block = new Block($f3);
                echo $block->justById($search)['block'];
            }
            else if ($item == 'height') {
                $block = new Block($f3);
                echo $block->justByHeight($search)['height'];
            }
            else if ($item == 'account') {
                $account = new Account($f3);
                if (is_numeric($search)) echo $account->justAccount($search)['account'];
                else echo $account->justAccount($search)['accountRS'];
            }
            else if ($item == 'transaction') {
                $transaction = new Transaction($f3);
                echo $transaction->justTransaction($search)['transaction'];
            }
        }

        function notFound() {
            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function block($f3) {
            $blocks = new Block($f3);

            $id = $f3->get('PARAMS.block');
            $f3->set('block', $blocks->getById($id));

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            if ($f3->get('block')) echo \Template::instance()->render('block.tpl');
            else echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function height($f3) {
            $blocks = new Block($f3);

            $height = $f3->get('PARAMS.height');
            $f3->set('block', $blocks->getByHeight($height));

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            if ($f3->get('block')) echo \Template::instance()->render('block.tpl');
            else echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

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

        function account($f3) {
            $account = new Account($f3);

            $id = $f3->get('PARAMS.account');
            $f3->set('account', $account->getAccount($id));

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            if ($f3->get('account')) echo \Template::instance()->render('account.tpl');
            else echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

    }