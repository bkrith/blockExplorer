kalimera
                <repeat group="{{ @blocks }}" value="{{ @block }}">
                    <tr>
                        <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/block/{{ @block.blockId }}">{{ @block.height }}</a></td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.timestamp }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.netDiff }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.deadline }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @block.reward }} / {{ @block.fee }}</td>
                        <td class="mdl-data-table__cell--non-numeric"><a href="{{ @BASE }}/account/{{ @block.generator }}">{{ @block.generatorName }}<br>{{ @block.generatorRS }}</a></td>
                        <td class="mdl-data-table__cell--non-numeric bold"><a class="winnerPoolLink" href="{{ @BASE }}/account/{{ @block.pool }}">{{ @block.poolName }}</a></td>
                    </tr>
                </repeat>