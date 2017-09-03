
<?php

    class BlockController {

        function block($f3) {
            $blocks = new Block();

            $id = $f3->get('PARAMS.block');
            $f3->set('block', $blocks->getById($id));
            $f3->set('title', $f3->get('mainTitle') . ' :: Block ' . $f3->get('block')['block']);

            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->find(null, array('limit' => 1))[0];

            $f3->set('market', $marketValues);

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            if ($f3->get('block')) echo \Template::instance()->render('block.tpl');
            else echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function blocks($f3) {
            $blocks = new Block();
            $page = $f3->get('PARAMS.page');
            $f3->set('blocks', $blocks->getBlockPage($page));

            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->find(null, array('limit' => 1))[0];

            $f3->set('market', $marketValues);

            echo \Template::instance()->render('blocks.tpl');
        }

        function height($f3) {
            $blocks = new Block();

            $height = $f3->get('PARAMS.height');
            $f3->set('block', $blocks->getByHeight($height));
            $f3->set('title', $f3->get('mainTitle') . ' :: Block #' . $f3->get('block')['height']);

            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->find(null, array('limit' => 1))[0];

            $f3->set('market', $marketValues);

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            if ($f3->get('block')) echo \Template::instance()->render('block.tpl');
            else echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

    }