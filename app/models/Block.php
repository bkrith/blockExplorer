<!--
Block Explorer - Burstcoin block explorer 
Copyright (C) 2017 Vassilis 

This program is free software: you can redistribute it and/or modify it under the terms of 
the GNU General Public License as published by the Free Software Foundation, either version 
3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. 
If not, see <http://www.gnu.org/licenses/>.

Make a donation to the author Vassilis ( BURST-YY7Z-K8KK-E2B9-AKQCQ )

-->

<?php

    class Block {

        private $wallet = '';

        public function __construct($f3) {
            $this->wallet = $f3->get('wallet');
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
            $block['timestamp'] = date('Y-m-d H:i:s', 1407729600 + $block['timestamp']);
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
                $transactions[$key]['timestamp'] = date('Y-m-d H:i:s', 1407729600 + $value['timestamp']);
                if ($transactions[$key]['amountNQT'] <= 0) $transactions[$key]['amountNQT'] = 0;
                if ($transactions[$key]['feeNQT'] <= 0) $transactions[$key]['feeNQT'] = 0;
            }

            return $transactions;
        }

    }
