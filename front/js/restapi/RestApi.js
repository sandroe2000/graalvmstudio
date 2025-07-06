export class RestApi {

  constructor(app) {
    this.app = app;
  }

  template(){
    return `
    <div id="rest-grid">
      <search>
        <div class="restSearchBox d-flex">
          <i class="bi bi-search"></i>
          <input type="search" id="btnSearchRest" class="form-control my-2 me-2" placeholder="Search" aria-label="Search" />
        </div>
      </search>
      <section id="secContent" class="px-2 py-2 scrollbar custom-scrollbar"></section>
      <div id="floatSectionMenu">
        <button class="btn btn-sm btn-light">
          <i class="bi bi-chevron-double-left"></i>
        </button>
      </div>
      <header class="px-2 py-2">
        <div class="row  g-1">
          <div class="col">
            <div class="input-group mb-3">
              <button id="btnMethods" class="btn btn-light dropdown-toggle btn-border" type="button" data-bs-toggle="dropdown" aria-expanded="false">GET</button>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="javascript:void(0);" onclick="application.getComponentByName('RestApi').setMethods('GET');">GET</a></li>
                <li><a class="dropdown-item" href="javascript:void(0);" onclick="application.getComponentByName('RestApi').setMethods('POST');">POST</a></li>
                <li><a class="dropdown-item" href="javascript:void(0);" onclick="application.getComponentByName('RestApi').setMethods('PUT');">PUT</a></li>
                <li><a class="dropdown-item" href="javascript:void(0);" onclick="application.getComponentByName('RestApi').setMethods('PATCH');">PATCH</a></li>
                <li><a class="dropdown-item" href="javascript:void(0);" onclick="application.getComponentByName('RestApi').setMethods('DELETE');">DELETE</a></li>
                <li><a class="dropdown-item" href="javascript:void(0);" onclick="application.getComponentByName('RestApi').setMethods('HEAD');">HEAD</a></li>
                <li><a class="dropdown-item" href="javascript:void(0);" onclick="application.getComponentByName('RestApi').setMethods('OPTIONS');">OPTIONS</a></li>
              </ul>
              <input type="text" class="form-control" aria-label="Enter URL or paste text" placeholder="Enter URL or paste text" />
            </div>
          </div>
          <div class="col-auto">
            <button id="frmField_btnSave" type="button" class="btn btn-success">Send</button>
            <button id="frmField_btnSave" type="button" class="btn btn-secondary">New</button>
            <button id="frmField_btnSave" type="button" class="btn btn-primary">Save</button>
          </div>
        </div>
      </header>
      <main>
        <div id="mainCode" class="container-fluid" style="display: block">
          <div id="restTop" class=" px-2 py-2">
            <div class="row g-1">
              <div class="col">
                <nav>
                  <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button"
                      role="tab" aria-controls="nav-home" aria-selected="false">Headers</button>
                    <button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile"
                      type="button" role="tab" aria-controls="nav-profile" aria-selected="true">Body</button>
                  </div>
                </nav>
                <div class="tab-content" id="nav-tabContent">
                  <div class="tab-pane fade" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
                    <div class="table-responsive" id="responsiveHeaders">
                      <table id="tblHeaders" class="table e table-sm">
                        <thead>
                          <tr>
                            <th></th>
                            <th>Key</th>
                            <th>Value</th>
                            <th>Description</th>
                            <th class="align-middle text-center">
                              <i id="icoPlusHeader" class="bi bi-plus-circle"></i>
                            </th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td class="align-middle text-center"><input type="checkbox" class="form-check-input" checked />
                            </td>
                            <td><input type="text" class="form-control" value="Content-Type" /></td>
                            <td><input type="text" class="form-control" value="application/json" /></td>
                            <td><input type="text" class="form-control" /></td>
                            <td class="align-middle text-center"><i class="bi bi-trash" onclick="javascript:this.closest('tr').remove();"></i></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                  <div class="tab-pane fade active show" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
                    <div class="row g-1">
                      <div class="col py-2 px-2">
                        <div class="form-check form-check-inline">
                          <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadioNone" checked value="none">
                          <label class="form-check-label" for="inlineRadioNone">none</label>
                        </div>
                        <div class="form-check form-check-inline">
                          <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadioFormData" value="form-data">
                          <label class="form-check-label" for="inlineRadioFormData">form-data</label>
                        </div>
                        <div class="form-check form-check-inline">
                          <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadioFormUrlecnoded" value="x-www-form-urlecnoded">
                          <label class="form-check-label" for="inlineRadioFormUrlecnoded">x-www-form-urlecnoded</label>
                        </div>
                        <div class="form-check form-check-inline">
                          <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadioRaw" value="raw">
                          <label class="form-check-label" for="inlineRadioRaw">raw</label>
                        </div>
                        <div class="form-check form-check-inline">
                          <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadioBinary" value="bynary">
                          <label class="form-check-label" for="inlineRadioBinary">binary</label>
                        </div>
                      </div>
                    </div>
                    <div class="row g-1">
                      <div class="col pt-2 pe-2">
                        <div class="table-responsive hidden" id="responsiveFormData">
                          <table id="tblFormData" class="table e table-sm">
                            <thead>
                              <tr>
                                <th></th>
                                <th>Key</th>
                                <th>Value</th>
                                <th>Description</th>
                                <th class="align-middle text-center">
                                  <i id="icoPlusFormData" class="bi bi-plus-circle"></i>
                                </th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <td class="align-middle text-center"><input type="checkbox" class="form-check-input" checked /></td>
                                <td><input type="text" class="form-control" /></td>
                                <td><input type="text" class="form-control" /></td>
                                <td><input type="text" class="form-control" /></td>
                                <td class="align-middle text-center"><i class="bi bi-trash" onclick="javascript:this.closest('tr').remove();"></i></td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                        <div class="table-responsive hidden" id="responsiveFormUrlecnoded">
                          <table id="tblFormUrlecnoded" class="table e table-sm">
                            <thead>
                              <tr>
                                <th></th>
                                <th>Key</th>
                                <th>Value</th>
                                <th>Description</th>
                                <th class="align-middle text-center">
                                  <i id="icoPlusFormUrlecnoded" class="bi bi-plus-circle"></i>
                                </th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <td class="align-middle text-center"><input type="checkbox" class="form-check-input" checked /></td>
                                <td><input type="text" class="form-control" /></td>
                                <td><input type="text" class="form-control" /></td>
                                <td><input type="text" class="form-control" /></td>
                                <td class="align-middle text-center"><i class="bi bi-trash"
                                    onclick="javascript:this.closest('tr').remove();"></i></td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                        <div id="divRaw" class="hidden"></div>
                        <div id="divBinary" class="hidden">
                          <input type="file" class="form-control" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div id="divResult">
            <div class="d-flex justify-content-center align-items-center" style="height: 100%;">
              <div style="text-align:center;">
                <img src="/assets/images/rocket-launch.avif" height="160px" />
                <div>Enter the URL and click Send to get a response</div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>`;
  }

  init(){
    this.events();
  }

  events() {

    this.noneHeight();

    this.rawEditor = monaco.editor.create(document.querySelector('#divRaw'), {
      language: 'json',
      automaticLayout: true,
      padding: {
          top: 10
      },
      formatOnPaste: true
    });

    const tabEl = document.querySelectorAll('button[data-bs-toggle="tab"]')
    tabEl.forEach(element => {
      element.addEventListener('shown.bs.tab', event => {
        if(event.target.getAttribute('id')=='nav-home-tab'){
          this.tableHeight();
        }else{
          if(document.querySelector('#inlineRadioNone').checked){
            this.noneHeight();
          }else{
            this.tableHeight();
          }
        }
      });
    });

    document.querySelector('#floatSectionMenu').addEventListener('click', this.showHideSection);

    document.querySelector('#inlineRadioNone').addEventListener('click', async (event) => {
      await this.hide();
      this.noneHeight();
    });

    document.querySelector('#inlineRadioFormData').addEventListener('click', async (event) => {
      await this.hide();
      this.tableHeight();
      document.querySelector('#responsiveFormData').classList.remove('hidden');
    });

    document.querySelector('#inlineRadioFormUrlecnoded').addEventListener('click', async (event) => {
      await this.hide();
      this.tableHeight();
      document.querySelector('#responsiveFormUrlecnoded').classList.remove('hidden');
    });

    document.querySelector('#inlineRadioFormUrlecnoded').addEventListener('click', async (event) => {
      await this.hide();
      this.tableHeight();
      document.querySelector('#responsiveFormUrlecnoded').classList.remove('hidden');
    });

    document.querySelector('#inlineRadioRaw').addEventListener('click', async (event) => {
      await this.hide();
      this.tableHeight();
      document.querySelector('#divRaw').classList.remove('hidden');
    });

    document.querySelector('#inlineRadioBinary').addEventListener('click', async (event) => {
      await this.hide();
      this.tableHeight();
      document.querySelector('#divBinary').classList.remove('hidden');
    });

    document.querySelector('#icoPlusHeader').addEventListener('click', (event) => {
      let tr = `<tr>
          <td class="align-middle text-center"><input type="checkbox" class="form-check-input" checked /></td>
          <td><input type="text" class="form-control" /></td>
          <td><input type="text" class="form-control" /></td>
          <td><input type="text" class="form-control" /></td>
          <td class="align-middle text-center"><i class="bi bi-trash" onclick="javascript:this.closest('tr').remove();"></i></td>
        </tr>`;
        document.querySelector('#tblHeaders tbody').insertAdjacentHTML('beforeend', tr);
    });

    document.querySelector('#icoPlusFormData').addEventListener('click', (event) => {
      let tr = `<tr>
          <td class="align-middle text-center"><input type="checkbox" class="form-check-input" checked /></td>
          <td><input type="text" class="form-control" /></td>
          <td><input type="text" class="form-control" /></td>
          <td><input type="text" class="form-control" /></td>
          <td class="align-middle text-center"><i class="bi bi-trash" onclick="javascript:this.closest('tr').remove();"></i></td>
        </tr>`;
        document.querySelector('#tblFormData tbody').insertAdjacentHTML('beforeend', tr);
    });

    document.querySelector('#icoPlusFormUrlecnoded').addEventListener('click', (event) => {
      let tr = `<tr>
          <td class="align-middle text-center"><input type="checkbox" class="form-check-input" checked /></td>
          <td><input type="text" class="form-control" /></td>
          <td><input type="text" class="form-control" /></td>
          <td><input type="text" class="form-control" /></td>
          <td class="align-middle text-center"><i class="bi bi-trash" onclick="javascript:this.closest('tr').remove();"></i></td>
        </tr>`;
        document.querySelector('#tblFormUrlecnoded tbody').insertAdjacentHTML('beforeend', tr);
    });

  }

  noneHeight(){
    let divResult = document.querySelector('#divResult');
    let height = window.innerHeight;
    divResult.style.height = `${height-223}px`;
  }

  tableHeight(){
    let divResult = document.querySelector('#divResult');
    let height = window.innerHeight;
    divResult.style.height = `${height-423}px`;
  }

  async hide(){

    if(!document.querySelector('#responsiveFormData').classList.contains('hidden')){
      document.querySelector('#responsiveFormData').classList.add('hidden');
    }

    if(!document.querySelector('#responsiveFormUrlecnoded').classList.contains('hidden')){
      document.querySelector('#responsiveFormUrlecnoded').classList.add('hidden');
    }

    if(!document.querySelector('#divRaw').classList.contains('hidden')){
      document.querySelector('#divRaw').classList.add('hidden');
    }

    if(!document.querySelector('#divBinary').classList.contains('hidden')){
      document.querySelector('#divBinary').classList.add('hidden');
    }
  }

  showHideSection(event) {

    const btn = event.target.closest('button');
    const sec = btn.querySelector('i');

    if (sec.classList.contains('bi-chevron-double-right')) {
      sec.classList.add('bi-chevron-double-left');
      sec.classList.remove('bi-chevron-double-right');
      document.querySelector('div#rest-grid').style.gridTemplateAreas = `"search header" "section main"`;
    } else if (sec.classList.contains('bi-chevron-double-left')) {
      sec.classList.add('bi-chevron-double-right');
      sec.classList.remove('bi-chevron-double-left');
      document.querySelector('div#rest-grid').style.gridTemplateAreas = `"header header" "main main"`;
    }
  }

  setMethods(method){
    document.querySelector('#btnMethods').textContent = method;
  }
}