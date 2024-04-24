using System.Configuration;

/// <summary>
/// Summary description for WebConfigSections
/// </summary>
namespace ADRCIA
{

    public class WebConfigSection : ConfigurationSection
    {
        [ConfigurationProperty("ConnString", IsRequired = false)]
        public string connString
        {
            get { return (string)base["ConnString"]; }
        }

        [ConfigurationProperty("domain", IsRequired = true)]
        public string domain
        {
            get { return (string)base["domain"]; }
        }

        [ConfigurationProperty("adPath", IsRequired = true)]
        public string adPath
        {
            get { return (string)base["adPath"]; }
        }

        [ConfigurationProperty("userDBName", IsRequired = true)]
        public string userDBName
        {
            get { return (string)base["userDBName"]; }
        }
    }

}
