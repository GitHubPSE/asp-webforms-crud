using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(asp_webforms_crud.Startup))]
namespace asp_webforms_crud
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
