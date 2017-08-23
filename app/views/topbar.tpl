
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <span class="mdl-layout-title"><a href="{{ @BASE }}"><i class="material-icons">view_quilt</i>Burst Explorer</a></span>
            <div class="mdl-layout-spacer"></div>
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable
                mdl-textfield--floating-label mdl-textfield--align-right">
                <label class="mdl-button mdl-js-button mdl-button--icon"
                for="searchFld">
                <i class="material-icons">search</i>
                </label>
                <div class="mdl-textfield__expandable-holder">
                    <input class="mdl-textfield__input" type="text" name="sample"
                        id="searchFld">
                </div>
            </div>
        </div>
    </header>

    <script>

        var AJAX = function (params) {
            this.server ={};
            this.url = params.url;
            this.method = params.method;
            this.dataType = params.dataType;
            this.formData = params.formData;

            this.init = function(){
                if(typeof XMLHttpRequest != 'undefined'){
                    this.server = new XMLHttpRequest();

                    //Open first, before setting the request headers.
                    this.server.open(this.method, this.url, true);

                    //Now set the request headers.
                    this.server.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                    //this.server.setRequestHeader('Content-length', this.formData.length);
                    //this.server.setRequestHeader('Connection', 'close');
                    console.log("XMLHttpRequest created.");
                    return true;
                }
            };

            this.send = function(){
                if(this.init()){
                    this.server.send(this.formData);
                }
            };

        };

        document.getElementById('searchFld').addEventListener('keypress', (event) => {
            if (event.keyCode === 13) {
                let search = document.getElementById('searchFld').value;
                let xhttp = []; 
                xhttp[0] = new XMLHttpRequest();
                xhttp[1] = new XMLHttpRequest();
                xhttp[2] = new XMLHttpRequest();
                xhttp[3] = new XMLHttpRequest();
                let item = ['block', 'height', 'account', 'transaction'];
                let i = 0;

                xhttp[0].onreadystatechange = function() {
                    if (this.readyState === this.DONE && this.status === 200) {
                        if (search == this.responseText) {
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
                        if (search == this.responseText) {
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
                        if (search == this.responseText) {
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
                        if (search == this.responseText) {
                            console.log('transaction exist');
                            window.location.href = '{{ @BASE }}/transaction/' + search;
                        }
                        else {
                            window.location.href = '{{ @BASE }}/not-found';
                        }
                    }
                }

                xhttp[0].open("GET", "{{ @BASE }}/search/block/" + search);
                xhttp[0].send();
            }

            event.stopPropagation? event.stopPropagation() : event.cancelBubble = true;
        })
    </script>

    <main class="mdl-layout__content">
        <div class="page-content">