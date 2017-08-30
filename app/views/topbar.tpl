
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <check if="{{ @isWinners || @isSettings }}">
                <true>
                    <span class="mdl-layout-title"><a href="{{ @BASE }}/winners">{{ @winnersTitle }}</a></span>
                </true>
                <false>
                    <span class="mdl-layout-title"><a href="{{ @BASE }}">{{ @mainTitle }}</a></span>
                </false>
            </check>
            <span class="mdl-layout--large-screen-only showDate" id="clockbox"></span>
            <check if="{{ @isWinners && 1 == 0 }}">
                <true>
                    <span class="showWinnersDetails">{{ @countWinBlocks }} Blocks today | Current block #{{ @blocks[0].height + 1 }} (<span id="countNext"></span>)</span>
                </true>
            </check>
            <div class="mdl-layout-spacer"></div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable
                mdl-textfield--floating-label mdl-textfield--align-right">
                <label class="mdl-button mdl-js-button mdl-button--icon"
                for="searchFld">
                <i class="material-icons">search</i>
                </label>
                <div class="mdl-textfield__expandable-holder">
                    <input class="mdl-textfield__input" type="text" name="sample" isWinners="{{ @isWinners }}"
                        id="searchFld">
                </div>
            </div>
            <check if="{{ @isWinners || @isSettings }}">
                <true>
                    <div>
                        <a id="settingsLink" href="{{ @BASE }}/winners/settings" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                            <i class="material-icons">settings</i>
                        </a>
                    </div>
                </true>
            </check>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title sideTitle">Burst tools</span>
        <nav class="mdl-navigation">
            <check if="{{ @isWinners || @isSettings }}">
                <true>
                    <a class="mdl-navigation__link" href="{{ @BASE }}"><i class="material-icons bigIcons">view_day</i> Burst Explorer</a>
                </true>
                <false>
                    <a class="mdl-navigation__link" href="{{ @BASE }}/winners"><i class="material-icons bigIcons">done_all</i> Winners</a>
                </false>
            </check>
        </nav>
    </div>

    <script>

        isSearching = false;

        tday=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
        tmonth=new Array("January","February","March","April","May","June","July","August","September","October","November","December");

        function GetClock() {
            let sd = new Date();

            let utc = sd.getTime() + (sd.getTimezoneOffset() * 60000);

            let d = new Date(utc + (3600000 * 3)); // 3 is timezone

            let difDate = new Date();
            let block = '{{ @blocks[0].timestamp }}';
            let blockSplit = block.split(' ');
            let blockDate = blockSplit[0].split('-');
            let blockTime = blockSplit[1].split(':');
            
            difDate.setFullYear(parseInt(blockDate[0]));
            difDate.setMonth(parseInt(blockDate[1]) - 1);
            difDate.setDate(parseInt(blockDate[2]));
            difDate.setHours(blockTime[0]);
            difDate.setMinutes(blockTime[1]);
            difDate.setSeconds(blockTime[2]);

            $('#countNext').html(toTime(new Date(((d - difDate) / 1000))));
            $('#countNext2').html(toTime(new Date(((d - difDate) / 1000))));
            
            document.getElementById('clockbox').innerHTML = getDateTime(d);
            document.getElementById('clockbox2').innerHTML = getDateTime(d);
        }

        function toTime(t) {
            let hours = 0;
            let mins = 0;
            let secs = 0;
            let output = '';

            mins = parseInt(t / 60);
            secs = t - (mins * 60);
            if (mins > 60) {
                hours = parseInt(mins / 60);
                mins = mins - (hours * 60);
            }

            if (hours > 0) output = hours + ' Hours ';
            if (mins > 0) output += mins + ' Mins ';
            if (secs > 0) output += secs + ' Secs ';

            return output;
        }

        function getDateTime(d, timeOnly = false) {
            let output = '';
            if (!timeOnly) {
                let nday = d.getDay(),
                    nmonth = d.getMonth(),
                    ndate = d.getDate(),
                    nyear = d.getFullYear();

                output = tday[nday]+", "+tmonth[nmonth]+" "+ndate+", "+nyear+" ";
            }

            let nhour = d.getHours(),
                nmin = d.getMinutes(),
                nsec = d.getSeconds();

            if(nmin <= 9) nmin = "0"+nmin
            if(nsec <= 9) nsec = "0"+nsec;

            output += nhour+":"+nmin+":"+nsec;

            return output;
        }

        window.onload=() => {
            if (!parseInt('{{ @isSettings }}')) {    
                GetClock();
                setInterval(GetClock,1000);
            }
            setInterval(refresh, 5000);
        }

        let refresh = () => {
            if ($('#searchFld').attr('isWinners') == true) {
                $.ajax({
                    url: '/blockchain/status',
                    error: () => {
                        console.log('no access to app api');
                    },
                    success: (blockchainData) => {
                        let chainHeight = JSON.parse(blockchainData).lastBlockchainFeederHeight;

                        console.log('Blockchain status: ' + chainHeight);

                        $.ajax({
                            url: '/mining/info',
                            error: () => {
                                console.log('no access to app api');
                            },
                            success: (miningData) => {
                                let walletHeight = JSON.parse(miningData).height - 1;
                                let winnersHeight = parseInt('{{ @blocks[0].height}}');
                                
                                if (walletHeight == chainHeight) {
                                    if (walletHeight > winnersHeight) {
                                        if (isSearching == false && $('#searchFld').attr('isWinners') == true) location.reload();
                                    }
                                }
                                else {
                                    console.log('Waiting.. (We are in forked chain!)');
                                }
                            }
                        });
                    }
                });
            }
        }; // check status for forked and refresh blocks

        let clean = () => {
            if ($('#searchFld').attr('isWinners') == true) {
                $.ajax({
                    url: '/clean',
                    error: () => {
                        console.log('no access to app api');
                    },
                    success: (cleanData) => {
                        console.log(JSON.parse(cleanData));
                    }
                });
            }
        }; // check for old blocks and erase them

        clean();

        document.getElementById('searchFld').addEventListener('keypress', (event) => {
            if (event.keyCode === 13) {
                let search = document.getElementById('searchFld').value.trim();

                if ($('#searchFld').attr('isWinners') == true) {
                    $.ajax({
                        url: '/winners/pool/' + search,
                        datatype: 'html',
                        error: () => {
                            console.log('no access to app api');
                        },
                        success: (html) => {
                            $('#winnersTableBody').html(html);
                            isSearching = true;
                        }
                    });
                }
                else {
                    let xhttp = []; 
                    xhttp[0] = new XMLHttpRequest();
                    xhttp[1] = new XMLHttpRequest();
                    xhttp[2] = new XMLHttpRequest();
                    xhttp[3] = new XMLHttpRequest();
                    let i = 0;

                    xhttp[0].onreadystatechange = function() {
                        if (this.readyState === this.DONE && this.status === 200) {
                            console.log(search, this.responseText.trim());
                            if (search == this.responseText.trim()) {
                                console.log('block exist');
                                window.location.href = '{{ @BASE }}/block/' + search;
                            }
                            else{
                                xhttp[1].open("GET", "{{ @BASE }}/search/height/" + search);
                                xhttp[1].send();
                            }
                        }
                    }

                    xhttp[1].onreadystatechange = function() {
                        if (this.readyState === this.DONE && this.status === 200) {
                            console.log(search, this.responseText.trim());
                            if (search == this.responseText.trim()) {
                                console.log('height exist');
                                window.location.href = '{{ @BASE }}/height/' + search;
                            }
                            else{
                                xhttp[2].open("GET", "{{ @BASE }}/search/account/" + search);
                                xhttp[2].send();
                            }
                        }
                    }

                    xhttp[2].onreadystatechange = function() {
                        if (this.readyState === this.DONE && this.status === 200) {
                            console.log(search, this.responseText.trim());
                            if (search == this.responseText.trim()) {
                                console.log('account exist');
                                window.location.href = '{{ @BASE }}/account/' + search;
                            }
                            else{
                                xhttp[3].open("GET", "{{ @BASE }}/search/transaction/" + search);
                                xhttp[3].send();
                            }
                        }
                    }

                    xhttp[3].onreadystatechange = function() {
                        if (this.readyState === this.DONE && this.status === 200) {
                            console.log(search, this.responseText.trim());
                            if (search == this.responseText.trim()) {
                                console.log('transaction exist');
                                window.location.href = '{{ @BASE }}/transaction/' + search;
                            }
                            else {
                                console.log(search, this.responseText.trim());
                                window.location.href = '{{ @BASE }}/not-found';
                            }
                        }
                    }

                    xhttp[0].open("GET", "{{ @BASE }}/search/block/" + search);
                    xhttp[0].send();
                }
            }

            event.stopPropagation? event.stopPropagation() : event.cancelBubble = true;
        })
        
    </script>

    <main class="mdl-layout__content">
        <div class="page-content">