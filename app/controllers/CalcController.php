
<?php

    class CalcController {

        function home($f3) { 
            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $block = $blocks->find(null, array('order' => 'height desc', 'limit' => 1))[0];
            
            $f3->set('blockReward', $block['reward']);
            $f3->set('baseTarget', intval(18325193796 / $block['netDiff']));

            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->find(null, array('limit' => 1))[0];

            $f3->set('market', $marketValues);

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('calculator.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

    }