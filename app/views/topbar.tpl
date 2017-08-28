
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <check if="{{ @isWinners }}">
                <true>
                    <span class="mdl-layout-title"><a href="{{ @BASE }}/winners">{{ @winnersTitle }}</a></span>
                </true>
                <false>
                    <span class="mdl-layout-title"><a href="{{ @BASE }}">{{ @mainTitle }}</a></span>
                </false>
            </check>
            <span class="mdl-layout--large-screen-only showDate" id="clockbox">{{ date('l, F d, Y H:i:s') }}</span>
            <check if="{{ @isWinners }}">
                <true>
                    <span class="showWinnersDetails">{{ @countWinBlocks }} Blocks today | Current block #{{ @blocks[0].height + 1 }}</span>
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
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title sideTitle">Burst tools</span>
        <nav class="mdl-navigation">
            <check if="{{ @isWinners }}">
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

        let GetClock = () => {
            let d=new Date();
            let nday=d.getDay(),nmonth=d.getMonth(),ndate=d.getDate(),nyear=d.getFullYear();
            let nhour=d.getHours(),nmin=d.getMinutes(),nsec=d.getSeconds();
            if(nmin<=9) nmin="0"+nmin
            if(nsec<=9) nsec="0"+nsec;

            document.getElementById('clockbox').innerHTML=""+tday[nday]+", "+tmonth[nmonth]+" "+ndate+", "+nyear+" "+nhour+":"+nmin+":"+nsec+"";
        }

        window.onload=() => {
            GetClock();
            setInterval(GetClock,1000);
        }

        setTimeout(() => {
            if (isSearching == false && $('#searchFld').attr('isWinners') == true) location.reload();
        }, 60000) // refreshing every minute

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