export class Sample {

    constructor(app) {
        this.app = app;
    }
    
    template() {
        return `
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    <i class="bi bi-alarm"></i> SAMPLE...
                </div>
            </div>
        </div>`;
    }
}