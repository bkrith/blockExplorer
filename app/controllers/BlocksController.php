
<?php

    class BlocksController {

        function blocks($f3) {
            $blocks = new Block($f3);

            $id = $f3->get('PARAMS.block');
            $f3->set('blocks', $blocks->getBlocksForPool());

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('blocks.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

    }