
<?php

    class MainController {

        function home($f3) {
            $page = $f3->get('PARAMS.page');

            $blocks = new Block();
            $f3->set('blocks', $blocks->getBlockPage($page));

            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->find(null, array('limit' => 1))[0];

            $f3->set('market', $marketValues);

            $f3->set('title', $f3->get('mainTitle'));

            $this->updateMarket();

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('home.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function updateMarket() {
            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->load(null, array('limit' => 1))[0];

            $d = new DateTime('', new DateTimeZone('Europe/Athens')); 
            $tm = strtotime($d->format('Y-m-d H:i:s'));
            $tm2 = strtotime(date($marketValues['timestamp']));

            if (($tm - $tm2) > 3600) {
                $cap = json_decode(file_get_contents('http://api.coinmarketcap.com/v1/ticker/burst/?convert=EUR'))[0];

                $market->btc = $cap->price_btc;
                $market->usd = $cap->price_usd;
                $market->eur = $cap->price_eur;

                $d = new DateTime('', new DateTimeZone('Europe/Athens')); 
                $market->timestamp = $d->format('Y-m-d H:i:s');

                $market->save();
            }
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