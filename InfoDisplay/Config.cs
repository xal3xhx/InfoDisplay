using System.Text.Json.Serialization;

namespace InfoDisplay;

public class Config {
    [JsonInclude] public bool SomeSetting = true;
}
