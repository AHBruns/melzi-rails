import {Controller} from "stimulus"

export default class extends Controller {
    static targets = ["mobileMenu", "button", "openIcon", "closeIcon"]

    open(event) {
        event.preventDefault();
        this.mobileMenuTarget.classList.remove("hidden");
        this.openIconTarget.classList.add("hidden");
        this.openIconTarget.classList.remove("block");
        this.closeIconTarget.classList.remove("hidden");
        this.closeIconTarget.classList.add("block");
        this.buttonTarget.dataset.action = "mobile-menu#close";
    }

    close(event) {
        event.preventDefault();
        console.log(this.mobileMenuTarget, this.openIconTarget)
        this.mobileMenuTarget.classList.add("hidden");
        this.openIconTarget.classList.remove("hidden");
        this.openIconTarget.classList.add("block");
        this.closeIconTarget.classList.add("hidden");
        this.closeIconTarget.classList.remove("block");
        this.buttonTarget.dataset.action = "mobile-menu#open";
    }
}