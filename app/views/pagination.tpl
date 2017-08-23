
<div class="mdl-paging floatLeft paginationDiv">
    <a id="previousBlock" href="{{ @BASE }}/{{ @previousPage }}" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__previous"><i class="material-icons">keyboard_arrow_left</i>
    </a>
    <a id="nextBlock" href="{{ @BASE }}/{{ @nextPage }}" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__next"><i class="material-icons">keyboard_arrow_right</i>
    </a>
    <span class="mdl-paging__count">Blocks #{{ @blocks.blocks[0].height }} - #{{ @blocks.blocks[count(@blocks.blocks) - 1].height }}</span>
</div>

<div class="mdl-paging floatRight paginationDiv"><a id="previousBlock" href="{{ @BASE }}" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__first"><i class="material-icons">arrow_back</i>
    </a>
    <a id="nextBlock" href="{{ @BASE }}/{{ @lastPage }}" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__last"><i class="material-icons">arrow_forward</i>
    </a>
</div>
