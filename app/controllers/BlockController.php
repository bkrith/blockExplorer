
<?php

    class BlockController {

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

    }