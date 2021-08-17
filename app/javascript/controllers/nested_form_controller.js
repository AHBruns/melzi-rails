import {Controller} from "stimulus"

export default class extends Controller {
    static targets = ["template", "container"]

    parser = new DOMParser()

    append(event) {
        window.temp = this.containerTarget;
        console.log("executing", this.containerTarget)
        event.preventDefault();
        const content = this.templateTarget.innerHTML.replace(/TEMPLATE_INDEX/g, Date.now());
        this.containerTarget.appendChild(this.parser.parseFromString(content, 'text/html').body.firstChild);
    }

    remove(event) {

    }
}