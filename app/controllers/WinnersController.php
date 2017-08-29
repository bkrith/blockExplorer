
<?php

    class WinnersController {

        private $wallet = '';
        private $timeSeed = 0;

        function winners($f3) {
            $this->wallet = $f3->get('wallet');
            $this->timeSeed = $f3->get('timeSeed');

            $id = $f3->get('PARAMS.block');
            $f3->set('title', $f3->get('winnersTitle'));
            $f3->set('isWinners', true);

            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $winBlock = $blocks->find(null, array('order' => 'height desc', 'limit' => 1));

            $lastBlock = $winBlock[0]->height;
            
            if (!$lastBlock) $lastBlock = 0;

            $this->getNewBlocks($lastBlock);

            $f3->set('winners', $this->getTopWinners());
            
            $f3->set('blocks', $this->formatBlocks($blocks->find(null, array('order' => 'height desc', 'limit' => 700))));
            $f3->set('countWinBlocks', count($blocks->find(array("FROM_UNIXTIME((timestamp + " . $this->timeSeed . "), '%Y-%m-%d') = CURDATE()"), array('order' => 'height desc', 'limit' => 700))));
            
            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('winners.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function pool($f3) {
            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $f3->set('blocks', $this->formatBlocks($blocks->find(array('poolName like "%' . $f3->get('PARAMS.pool') . '%"'), array('order' => 'height desc', 'limit' => 1000))));

            echo \Template::instance()->render('poolBlocks.tpl');
        }

        private function getLastBlock() {
            return $this->getApi($this->wallet . '/burst?requestType=getMiningInfo')['height'];
        }

        function getBlockStatus($f3) {
            echo json_encode($this->getApi($f3->get('wallet') . '/burst?requestType=getBlockchainStatus'));
        }

        function getMiningInfo($f3) {
            echo json_encode($this->getApi($f3->get('wallet') . '/burst?requestType=getMiningInfo'));
        }

        function clean($f3) {
            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $blocks->load(array("FROM_UNIXTIME((timestamp + " . $f3->get('timeSeed') . "), '%Y-%m-%d') < (CURDATE() - INTERVAL " . $f3->get('cleanPerDays') . " DAY)"));
            
            try {
                while(!$blocks->dry()) {
                    $blocks->erase();
                    $blocks->next();
                }
            }
            catch(\PDOException $e) {
                // Do nothing
            }
            
            echo json_encode(array('cleaned' => 'ok', 'count' => $blocks->count(array("FROM_UNIXTIME((timestamp + " . $f3->get('timeSeed') . "), '%Y-%m-%d') < (CURDATE() - INTERVAL " . $f3->get('cleanPerDays') . " DAY)"))));
        }

        function settings($f3) {
            $f3->set('isSettings', true);
            $f3->set('pools', $this->getPoolNames());

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('winners.settings.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function poolNames() {
            echo json_encode($this->getPoolNames());
        }

        private function getPoolNames() {
            return \Base::instance()->get('db')->exec('select distinct poolName from blocks order by poolName asc');
        }

        function topWinners($f3) {
            echo json_encode(\Base::instance()->get('db')->exec("SELECT poolName, count(poolName) as 'wins' from blocks where FROM_UNIXTIME((timestamp + " . $f3->get('timeSeed') . "), '%Y-%m-%d') = CURDATE()  group by poolName order by wins desc limit 10"));
        }

        private function getTopWinners() {
            $wins = \Base::instance()->get('db')->exec("SELECT poolName, count(poolName) as 'wins' from blocks where FROM_UNIXTIME((timestamp + " . $this->timeSeed . "), '%Y-%m-%d') = CURDATE()  group by poolName order by wins desc limit 10");
            
            if (count($wins) < 10) {
                for ($i = count($wins); $i < 10; $i++) {
                    $wins[$i] = array(
                        'poolName' => 'Waiting for pool'
                    );
                }
            }

            return $wins;
        }

        private function getNewBlocks($lastBlock) {
            $reallyLast = $this->getLastBlock();
            
            if ($lastBlock < $reallyLast) {
                // Get the last 1000 blocks for initialize
                if (($reallyLast - $lastBlock) > 1000) $lastBlock = $reallyLast - 1000;
                for($i = $lastBlock + 1; $i <= $reallyLast; $i++) {
                    $this->addBlock($i);
                }
            }
        }

        private function addBlock($height) {
            $tempBlock = [];

            $block = $this->getApi($this->wallet . '/burst?requestType=getBlock&height=' . $height);
            
            $tempBlock['generator'] = $block['generator'];
            $tempBlock['generatorRS'] = $block['generatorRS'];
            $tempBlock['baseTarget'] = $block['baseTarget'];
            $tempBlock['height'] = $block['height'];
            $tempBlock['timestamp'] = $block['timestamp'];
            
            $tempBlock['blockId'] = $block['block'];
            $tempBlock['generatorName'] = $this->getApi($this->wallet . '/burst?requestType=getAccount&account=' . $tempBlock['generator'])['name'];
            
            $assignment = $this->getApi($this->wallet . '/burst?requestType=getAccountTransactions&type=20&firstIndex=0&lastIndex=0&account=' . $tempBlock['generator'])['transactions'][0];
            
            $tempBlock['pool'] = $assignment['recipient'];
            $tempBlock['poolRS'] = $assignment['recipientRS'];
            
            if ($tempBlock['generator'] == $tempBlock['pool']) $tempBlock['poolName'] = 'Solo Miner';
            else {
                $tempBlock['poolName'] = $this->getApi($this->wallet . '/burst?requestType=getAccount&account=' . $tempBlock['pool'])['name'];
            }

            if (!trim($tempBlock['poolName'])) $tempBlock['poolName'] = 'Solo Miner';

            if ($tempBlock['baseTarget'] > 0) $tempBlock['netDiff'] = intval(18325193796 / intval($tempBlock['baseTarget']));
            else $tempBlock['netDiff'] = 0;

            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $timestamp = $blocks->find(null, array('order' => 'height desc', 'limit' => 1));

            $tempBlock['deadline'] = intval($tempBlock['timestamp']) - intval($timestamp[0]->timestamp);
            $tempBlock['reward'] = $block['blockReward'];
            $tempBlock['fee'] = $block['totalFeeNQT'];
            
            try {
                $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
                $blocks->reset();
                $blocks->blockId = $tempBlock['blockId'];
                $blocks->height = $tempBlock['height'];
                $blocks->generator = $tempBlock['generator'];
                $blocks->generatorRS = $tempBlock['generatorRS'];
                $blocks->generatorName = $tempBlock['generatorName'];
                $blocks->pool = $tempBlock['pool'];
                $blocks->poolRS = $tempBlock['poolRS'];
                $blocks->poolName = $tempBlock['poolName'];
                $blocks->timestamp = $tempBlock['timestamp'];
                $blocks->netDiff = $tempBlock['netDiff'];
                $blocks->deadline = $tempBlock['deadline'];
                $blocks->reward = $tempBlock['reward'];
                $blocks->fee = $tempBlock['fee'];
                $blocks->save();
            }
            catch(\PDOException $e) {
                // Do nothing
            }
        }

        private function getApi($url) { 
            return json_decode(file_get_contents($url), true);
        }

        private function formatBlocks($blocks) {
            $tempBlocks = [];

            foreach($blocks as $key => $value) {
                $tempBlocks[] = $this->formatBlock($value);
            }

            return $tempBlocks;
        }

        private function formatBlock($block) {
            $tempBlock = [];
            $this->timeSeed = 1407722400;

            $tempBlock['blockId'] = $block['blockId']; 
            $tempBlock['fee'] = intval($block['fee']) / 100000000;
            $tempBlock['deadline'] = date('i:s', $block['deadline']);
            $tempBlock['timestamp'] = date('Y-m-d H:i:s', intval($this->timeSeed) + intval($block['timestamp']));
            $tempBlock['reward'] = number_format($block['reward'], 0, '.', "'");
            $tempBlock['netDiff'] = $block['netDiff'];
            $tempBlock['height'] = $block['height'];
            $tempBlock['generator'] = $block['generator'];
            $tempBlock['generatorRS'] = $block['generatorRS'];
            $tempBlock['generatorName'] = $block['generatorName'];
            if (trim($tempBlock['generatorName']) == '') $tempBlock['generatorName'] = 'Undefined';
            $tempBlock['pool'] = $block['pool'];
            $tempBlock['poolRS'] = $block['poolRS'];
            $tempBlock['poolName'] = $block['poolName'];

            return $tempBlock;
        }

    }