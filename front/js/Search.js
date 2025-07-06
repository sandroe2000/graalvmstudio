export class Search{

    constructor(app){
        this.app = app
    }

    template(){
        return `
        <div class="row mx-2 g-1">
            <div class="col">                    
                    <input class="form-control form-control-sm" type="text" placeholder="Search">
            </div>
            <div class="col-auto">
                <button type="button" class="btn btn-sm btn-secondary" id="btnMainSearch">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </div>
        <div class="search-result"></div>`;
    }

    init(){
        this.search = document.querySelector('.search')
        this.searchInput = document.querySelector('.search-input')
        this.searchButton = document.querySelector('.search-button')
    }
}