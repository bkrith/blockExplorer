
<?php

    class Block {

        private $wallet = '';
        private $timeSeed = 0;

        public function __construct($f3) {
            $this->wallet = $f3->get('wallet');
            $this->timeSeed = $f3->get('timeSeed');
        }

        public function all($page) {
            if ($page > 0) $page = $page - 1;
            
            $blocks = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlocks&firstIndex=' . ($page * 100) . '&lastIndex=' . (($page * 100) + 99)), true);

            return $this->formatBlocks($blocks);
        }

        public function getLastBlock() {
            $status = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlockchainStatus'), true);
            $lastBlockHeight = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&block=' . $status['lastBlock']), true)['height'];
            
            return $lastBlockHeight;
        }

        public function getByHeight($height) {
            $block = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&height=' . $height . '&includeTransactions=true'), true);
            
            if ($block['errorCode'] == null) {
                $block = $this->formatBlock($block);
                $block['transactions'] = $this->formatTransactions($block['transactions']);
                
                return $block;
            }
            else {
                return null;
            }
        }

        public function justByHeight($height) {
            $block = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&height=' . $height . '&includeTransactions=true'), true);
            
            if ($block['errorCode'] == null) {
                return $block;
            }
            else {
                return null;
            }
        }

        public function getById($id) {
            $block = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&block=' . $id . '&includeTransactions=true'), true);
            
            if ($block['errorCode'] == null) {
                $block = $this->formatBlock($block);
                $block['transactions'] = $this->formatTransactions($block['transactions']);
                
                return $block;
            }
            else {
                return null;
            }
        }

        public function justById($id) {
            $block = json_decode(file_get_contents($this->wallet . '/burst?requestType=getBlock&block=' . $id . '&includeTransactions=true'), true);
            
            if ($block['errorCode'] == null) {                
                return $block;
            }
            else {
                return null;
            }
        }


        // Util Functions

        private function formatBlocks($blocks) {
            foreach($blocks['blocks'] as $key => $value) {
                $blocks['blocks'][$key] = $this->formatBlock($blocks['blocks'][$key]);
            }

            return $blocks;
        }

        private function formatBlock($block) {
            $block['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $block['timestamp']);
            $block['totalAmountNQT'] = number_format($block['totalAmountNQT'] / 100000000, 2, '.', "'");
            $block['totalFeeNQT'] = $block['totalFeeNQT'] / 100000000;
            $block['blockReward'] = number_format($block['blockReward'], 0, '.', "'");
            $block['payloadLength'] = round($block['payloadLength'] / 1024, 2) . 'K';

            if ($block['totalAmountNQT'] > 0) $block['bold'] = 'bold';

            if ($block['totalAmountNQT'] <= 0) $block['totalAmountNQT'] = 0;
            if ($block['totalFeeNQT'] <= 0) $block['totalFeeNQT'] = 0;

            return $block;
        }

        private function formatTransactions($transactions) {
            foreach($transactions as $key => $value) {
                $transactions[$key]['amountNQT'] = number_format($value['amountNQT'] / 100000000, 2, '.', "'");
                $transactions[$key]['feeNQT'] = $value['feeNQT'] / 100000000;
                $transactions[$key]['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $value['timestamp']);
                if ($transactions[$key]['amountNQT'] <= 0) $transactions[$key]['amountNQT'] = 0;
                if ($transactions[$key]['feeNQT'] <= 0) $transactions[$key]['feeNQT'] = 0;
            }

            return $transactions;
        }

    }
