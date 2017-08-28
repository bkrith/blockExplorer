
<?php

    class MainController {

        function home($f3) {
            $page = $f3->get('PARAMS.page');

            $blocks = new Block();
            $f3->set('blocks', $blocks->getBlockPage($page));

            $f3->set('title', $f3->get('mainTitle'));

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('home.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function search($f3) {
            $search = $f3->get('PARAMS.search');
            $item = $f3->get('PARAMS.item');
            if ($item == 'block') {
                $block = new Block();
                echo $block->justById($search)['block'];
            }
            else if ($item == 'height') {
                $block = new Block();
                echo $block->justByHeight($search)['height'];
            }
            else if ($item == 'account') {
                $account = new Account();
                if (is_numeric($search)) echo $account->justAccount($search)['account'];
                else echo $account->justAccount($search)['accountRS'];
            }
            else if ($item == 'transaction') {
                $transaction = new Transaction();
                echo $transaction->justTransaction($search)['transaction'];
            }
        }

        function notFound($f3) {
            $f3->set('title', $f3->get('mainTitle') . ' :: Not found');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

    }