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
        event.preventDefault();
        const container = event.target.closest(".__container");
        const fields = container.querySelector(".__fields");
        Array.from(container.querySelectorAll("input[name*='_destroy']")).map(field => {
            field.value = "true"
        });
        if (container.classList.contains("__existing")) {
            fields.style.pointerEvents = "none";
            fields.style.filter = "blur(4px)";
            event.target.innerHTML = "Undo Remove";
            event.target.dataset.action = "nested-form#unremove";
        } else {
            container.remove();
        }
    }

    unremove(event) {
        event.preventDefault();
        const container = event.target.closest(".__container");
        const fields = container.querySelector(".__fields");
        Array.from(container.querySelectorAll("input[name*='_destroy']")).map(field => {
            field.value = "false"
        });
        fields.style.pointerEvents = "auto";
        fields.style.filter = "";
        event.target.innerHTML = "Remove";
        event.target.dataset.action = "nested-form#remove";
    }
}