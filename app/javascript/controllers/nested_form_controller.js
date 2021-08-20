import {Controller} from "stimulus"

export default class extends Controller {
    static targets = ["template", "container", "source"]
    static values = {
        templateIndex: String
    }

    append(event) {
        event.preventDefault();
        const content = this.templateTarget.innerHTML.replaceAll(this.templateIndexValue, Date.now());
        this.sourceTarget.insertAdjacentHTML('beforebegin', content)
    }

    remove(event) {

    }
}